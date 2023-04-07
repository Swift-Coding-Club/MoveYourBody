//
//  ExerciseView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/10.
//

import SwiftUI

struct ExerciseView: View {
    
    @ObservedObject var workoutViewModel: WorkoutViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                Spacer()
                showExerciseName()
                Spacer()
                showExerciseImage()
                Spacer()
                showCounts()
                    .frame(height: 50)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func showExerciseName() -> some View {
        Text(workoutViewModel.currentExerciseName)
            .font(.system(size: 50, weight: .bold))
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.white)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    func showExerciseImage() -> some View {
        Image(workoutViewModel.currentImageName)
            .resizable()
            .frame(width: 300, height: 300)
    }
    
    @ViewBuilder
    func showCounts() -> some View {
        Text("\(45 - workoutViewModel.currentCount)")
            .font(.system(size: 50, weight: .semibold))
            .foregroundColor(.white)
            .overlay(
                CircularProgressBar(currentCount: $workoutViewModel.currentCount)
            )
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(workoutViewModel: WorkoutViewModel())
    }
}
