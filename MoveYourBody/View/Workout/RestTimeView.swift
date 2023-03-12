//
//  RestTimeView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/10.
//

import SwiftUI

struct RestTimeView: View {
    let nextExercise: String
    @Binding var leftSeconds: Int
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("다음 운동은...")
                        .font(.system(size: 25))
                    Text("\(nextExercise)")
                        .font(.system(size: 50))
                    Text("입니다")
                        .font(.system(size: 25))
                }
                
                Text("\(leftSeconds)초 후 시작합니다!")
                    .font(.system(size: 30))
            }
        }
        .foregroundColor(.white)
    }
}

struct RestTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RestTimeView(nextExercise: "벤트오버레터럴레이즈", leftSeconds: .constant(3))
    }
}
