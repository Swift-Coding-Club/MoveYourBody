//
//  NangView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/12.
//

import SwiftUI

struct AlarmSettingsView: View {
    
    @State private var showSheet = false
    @State private var selectedDate = Date()

    //UI 예시
    @State private var setAlarm1 = false

    var body: some View {
        ZStack {
            VStack(spacing: 70) {
                settingBar()
            }
            .environment(\.colorScheme, .dark)
        }
        
    }

    func settingBar() -> some View {
        NavigationView {
            VStack {
                List {
                    Toggle(isOn: $setAlarm1) {
                        Text("아침 운동")
                    }
                }
            }
            .navigationBarTitle("운동 알림")
            .navigationBarItems(leading: Button {
            } label: {
                Image(systemName: "arrowshape.backward.fill")
            }.buttonStyle(customButton())
            )
            .navigationBarItems(trailing: EditButton())
            .navigationBarItems(trailing: Button {
                self.showSheet = true
            } label: {
                Image(systemName: "plus")
            }
                .sheet(isPresented: self.$showSheet) {
                    plusAlarm()
                        .preferredColorScheme(.dark)
                })
        }
    }

    func plusAlarm() -> some View {
        NavigationView {
            
                VStack {
                    DatePicker("",selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                }
                .navigationBarTitle("새로운 알람", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                        self.showSheet = false}) {Text("취소")},
                                    trailing: Button{ } label: {Text("저장")})
        }
    }
    
    struct customButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(.green)
                .padding()
                .scaleEffect(configuration.isPressed ? 0.9 : 1)
        }
    }
}

struct NangView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmSettingsView()
    }
}
