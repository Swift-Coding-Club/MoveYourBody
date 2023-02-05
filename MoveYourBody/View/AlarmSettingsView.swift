//
//  NangView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/12.
//

import SwiftUI

struct AlarmSettingsView: View {
    @StateObject private var notificationManager = NotificationManager()
    @State private var isCreatePresented = false
    
    private static var notificationDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    private func timeDisplayText(from notification: UNNotificationRequest) -> String {
        guard let nextTriggerDate = (notification.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() else { return "" }
        return Self.notificationDateFormatter.string(from: nextTriggerDate)
    }
    
    @ViewBuilder
    var infoOverlayView: some View {
        switch notificationManager.authorizationStatus {
        case .authorized:
            if notificationManager.notifications.isEmpty {
                InfoOverlayView(
                    infoMessage: "알림이 없습니다",
                    buttonTitle: "Create",
                    systemImageName: "plus.circle",
                    action: {
                        isCreatePresented = true
                    }
                )
            }
        case .denied:
            InfoOverlayView(
                infoMessage: "알림 허용 권한을 변경하세요",
                buttonTitle: "Settings",
                systemImageName: "gear",
                action: {
                    if let url = URL(string: UIApplication.openSettingsURLString),
                       UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            )
        default:
            EmptyView()
        }
    }
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            
            VStack(spacing: 70) {
                List {
                    ForEach(notificationManager.notifications, id: \.identifier) { notification in
                        HStack {
                            Text(notification.content.title).fontWeight(.semibold)
                            Spacer()
                            Text(timeDisplayText(from: notification)).fontWeight(.bold)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(InsetGroupedListStyle())
                .overlay(infoOverlayView)
                .navigationTitle("운동 알림")
                .onAppear(perform: notificationManager.reloadAuthorizationStatus)
                .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
                    switch authorizationStatus {
                    case .notDetermined:
                        notificationManager.requestAuthorization()
                    case .authorized:
                        notificationManager.reloadLocalNotifications()
                        break
                    default:
                        break
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    notificationManager.reloadAuthorizationStatus()
                }
                .navigationBarItems(leading: Button {
                    
                } label: {
                    Image("go-back")
                })
                .navigationBarItems(trailing: Button {
                    isCreatePresented = true
                } label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                })
                .sheet(isPresented: $isCreatePresented) {
                    NavigationView {
                        CreateNotificationView(
                            notificationManager: notificationManager,
                            isPresented: $isCreatePresented)
                    }
                    .accentColor(.primary)
                }
            }
        }
    }
}

extension AlarmSettingsView {
    func delete(_ indexSet: IndexSet) {
        notificationManager.deleteLocalNotifications(identifiers: indexSet.map {
            notificationManager.notifications[$0].identifier
        })
        notificationManager.reloadLocalNotifications()
    }
}

struct AlarmSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmSettingsView()
    }
}
