//
//  NangView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/12.
//

import SwiftUI

struct NangView: View {

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
            .navigationBarItems(leading: EditButton())
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
                    trailing: Button(action: {
                        print("저장")}) {Text("저장")})
        }
    }
}

struct NangView_Previews: PreviewProvider {
    static var previews: some View {
        NangView()
    }
}
