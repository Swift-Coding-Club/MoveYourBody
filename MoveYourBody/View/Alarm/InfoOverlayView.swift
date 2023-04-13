//
//  InfoOverlayView.swift
//  MoveYourBody
//
//  Created by 정나영 on 2023/02/04.
//

import SwiftUI

struct InfoOverlayView: View {
    let infoMessage: String
    let buttonTitle: String
    let systemImageName: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text(infoMessage)
                .fontWeight(.bold)
                .font(.system(size: 26))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            
            Button {
                action()
            } label: {
                Label(buttonTitle, systemImage: systemImageName)
                    .foregroundColor(.black)
            }
            .padding()
            .background(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(8)
            
        }
    }
}

struct InfoOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        InfoOverlayView(infoMessage: "", buttonTitle: "", systemImageName: "", action: {})
    }
}
