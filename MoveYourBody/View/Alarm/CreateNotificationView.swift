//
//  CreateNotificationView.swift
//  MoveYourBody
//
//  Created by 정나영 on 2023/02/04.
//
import SwiftUI

struct CreateNotificationView: View {
    @ObservedObject var notificationManager: NotificationManager
    @State private var title = ""
    @State private var date = Date()
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            
            VStack(spacing: 16) {
                        DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                            .datePickerStyle(.wheel)
                            .colorScheme(.dark)
                        
                        TextField("제목을 입력하세요", text: $title)
                        
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color(.systemGray4))
                        .cornerRadius(5)
                        .hidden()

                        createButton()
                    }
                    .padding(.horizontal, 16)
            
            .scrollContentBackground(.hidden)
            .onDisappear {
                notificationManager.reloadLocalNotifications()
            }
            .navigationTitle("새로운 알람")
            .navigationBarItems(trailing: Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark")
                    .imageScale(.large)
                    .foregroundColor(.white)
            })
        }
    }
    
    func createButton() -> some View {
        Button {
            let dateComponents = Calendar.current.dateComponents([.hour,.minute], from: date)
            guard let hour = dateComponents.hour,
                  let minute = dateComponents.minute
            else { return }

            notificationManager.createLocalNotification(title: title, hour: hour, minute: minute) { error in
                if error == nil {
                    DispatchQueue.main.async {
                        self.isPresented = false
                    }
                }
            }
        } label: {
            Text("Create")
                .fontWeight(.semibold)
                .frame(width: 240)
                .foregroundColor(.white)
                //.contentShape(Rectangle())
        }
        .padding()
        //.background(Color("buttonBackgroundStart"))
        .cornerRadius(5)
        .buttonStyle(PlainButtonStyle())
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
    }
}

struct CreateNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNotificationView(
            notificationManager: NotificationManager(),
            isPresented: .constant(false))
    }
}   

