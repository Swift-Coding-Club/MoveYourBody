//
//  ExerciseView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/10.
//

import SwiftUI

struct ExerciseView: View {
    @Binding var currentKoreanCount: String
    let exerciseName: String
    let imageName: String
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 50) {
                showExerciseName()
                showExerciseImage()
                showCounts()
                    .frame(height: 50)
            }
        }
    }
    
    @ViewBuilder
    func showExerciseName() -> some View {
        Text(exerciseName)
            .font(.system(size: 50, weight: .bold))
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    func showExerciseImage() -> some View {
        ZStack {
            if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .frame(width: 300, height: 300)
            }
        }
    }
    
    @ViewBuilder
    func showCounts() -> some View {
        Text(currentKoreanCount)
            .font(.system(size: 50, weight: .semibold))
            .foregroundColor(.white)
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(currentKoreanCount: .constant("하나"), exerciseName: "바스켓볼", imageName: "basketBall_1")
    }
}
