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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
    
    var btnBack: some View {
        Button(action:{self.presentationMode.wrappedValue.dismiss()}){
            HStack{
                //Image("go-back")
                Image(systemName: "chevron.left")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
    
    var btnPlus: some View {
        Button {
            isCreatePresented = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 22))
                .fontWeight(.bold)
                .foregroundColor(Color(.white))
            
        }
    }

    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                
                VStack(spacing: 80) {
                    List {
                        ForEach(notificationManager.notifications, id: \.identifier) { notification in
                            HStack {
                                Text(timeDisplayText(from: notification))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(notification.content.title)
                                    .hidden()
                                    .fontWeight(.semibold)
                            }
                            
                        }
                        .onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(DefaultListStyle())
                    .overlay(infoOverlayView)
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
                    
                    .sheet(isPresented: $isCreatePresented) {
                        NavigationView {
                            CreateNotificationView(
                                notificationManager: notificationManager,
                                isPresented: $isCreatePresented)
                        }
                    }
                }
                
                .navigationBarItems(leading: btnBack)
                .navigationBarItems(trailing: btnPlus)
                .navigationTitle("운동 알림")
                
                .padding(16)
            }
        } .navigationBarBackButtonHidden()
        
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
