//
//  WorkoutSummary.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/12.
//

import SwiftUI

struct WorkoutSummaryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 10) {
                Spacer()
                Text("오운완!")
                    .font(.system(size: 80, weight: .heavy))
                Spacer()
                endButton()
                Spacer()
            }
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    func endButton() -> some View {

        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("END")
                .font(.system(size: 40, weight: .bold))
                .padding()
                .frame(width: 150, height: 150)
                .foregroundColor(.black)
                .background(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(Circle())
        }
    }
}

struct WorkoutSummary_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSummaryView()
    }
}
