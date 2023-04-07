//
//  CircularProgressBar.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/23.
//

import SwiftUI

struct CircularProgressBar: View {
    
    @Binding var currentCount: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .fill(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 100, height: 100)
                .overlay(
                    Circle()
                        .trim(from: 0, to: progress())
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.red)
                        .rotationEffect(Angle(degrees: -90))
                )
        }
        .onChange(of: currentCount) { newValue in
            print(newValue)
        }
    }
    
    func progress() -> CGFloat {
        return CGFloat(currentCount) / 45
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar(currentCount: .constant(10))
    }
}
