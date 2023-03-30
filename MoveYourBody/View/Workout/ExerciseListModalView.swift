//
//  ExerciseListModalView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/25.
//

import SwiftUI

struct ExerciseListModalView: View {
    
    @Binding var workouts: [Workout]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(workouts, id: \.id) { workout in
                    CustomTableViewCell(imageNames: workout.workoutImageNames, exerciseName: workout.workoutName, instructions: workout.instructions, considerations: workout.considerations)
                }
            }
            .background(Color("sheetBackground"))
            .edgesIgnoringSafeArea(.bottom)
            // bottom sheet가 덜 올라와 있으면 ScrollView 사이즈 줄이기
            .if(geometry.frame(in: .global).minY > UIScreen.main.bounds.midY) { view in
                view.frame(maxHeight: UIScreen.main.bounds.height * 0.2)
            }
            .if(geometry.frame(in: .global).minY < UIScreen.main.bounds.midY) { view in
                view.frame(maxHeight: UIScreen.main.bounds.height * 0.8)
            }
        }
    }
}

struct ExerciseListModalView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListModalView(workouts: .constant([
            Workout(workoutName: "얼터네이팅 덤벨 스윙", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                        ["alternatingDumbbelSwing_base", "alternatingDumbbelSwing_left", "alternatingDumbbelSwing_base", "alternatingDumbbelSwing_right"], bodyPart: .lowerBody, instructions: Constants.alternativeDumbbelSwingInstructions, considerations: Constants.alternativeDumbbelSwingConsiderations),
        ]))
    }
}
