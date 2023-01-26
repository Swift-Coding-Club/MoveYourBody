//
//  VideoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/17.
//

import SwiftUI

struct WorkoutView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 70) {
                secondCount()
                exerciseImage()
                showDescription()
            }
        }
    }
    
    @ViewBuilder
    func secondCount() -> some View {
        VStack {
            Text("20")
                .font(.system(size: 80, weight: .bold))
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    func exerciseImage() -> some View {
        ZStack {
            Image(systemName: "figure.strengthtraining.functional")
                .font(.system(size: 150))
                .foregroundColor(.white)
                
            Circle()
                .stroke(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 10)
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0, to: 0.33)
                .stroke(Color.red, lineWidth: 10)
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-90))
        }
    }
    
    @ViewBuilder
    func showDescription() -> some View {
        VStack(spacing: 20) {
            Text("허리를 펴고 앞을 보세요")
                .font(.system(size: 25, weight: .heavy))
                .opacity(0.8)
            
            Text("장요근에 자극을 느끼며")
                .font(.system(size: 40, weight: .bold))
            
            Text("10초간 스트레칭 하겠습니다")
                .font(.system(size: 25, weight: .heavy))
                .opacity(0.8)
        }
        .foregroundColor(.white)
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
