//
//  PrepareExerciseView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/23.
//

import SwiftUI

struct PrepareExerciseView: View {
   
    @Binding var currentCount: Int
    @Binding var nextExercise: String
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("다음 운동은")
                    .font(.system(size: 35))
                Text("\(nextExercise)")
                    .font(.system(size: 50, weight: .bold))
                Text("입니다.")
                    .font(.system(size: 35))
                
                Text("\(currentCount)초 후 시작합니다.")
                    .font(.system(size: 20))
            }
            .foregroundColor(.white)
            .padding(.horizontal)
        }
    }
}

struct PrepareExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareExerciseView(currentCount: .constant(10), nextExercise: .constant("하이 니"))
    }
}
