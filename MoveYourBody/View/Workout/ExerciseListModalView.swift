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
                ForEach(Array(zip(workouts.indices, workouts)), id: \.1) { index, workout in
                    VStack(spacing: 0) {
                        HStack {
                            if index == 0 {
                                Text("현재 동작")
                            } else if index == workouts.count - 1 {
                                Text("마지막 동작")
                            } else {
                                Text("다음 동작")
                            }
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 5, trailing: 0))
                        .foregroundColor(.white)
                        
                        CustomTableViewCell(imageNames: workout.workoutImageNames, exerciseName: workout.workoutName, instructions: workout.instructions, considerations: workout.considerations)
                    }
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
            Workout(workoutName: "얼터네이팅 덤벨 스윙", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                        ["alternatingDumbbelSwing_base", "alternatingDumbbelSwing_left", "alternatingDumbbelSwing_base", "alternatingDumbbelSwing_right"], bodyPart: .lowerBody, instructions: Constants.alternativeDumbbelSwingInstructions, considerations: Constants.alternativeDumbbelSwingConsiderations),
            Workout(workoutName: "얼터네이팅 덤벨 스윙", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                        ["alternatingDumbbelSwing_base", "alternatingDumbbelSwing_left", "alternatingDumbbelSwing_base", "alternatingDumbbelSwing_right"], bodyPart: .lowerBody, instructions: Constants.alternativeDumbbelSwingInstructions, considerations: Constants.alternativeDumbbelSwingConsiderations),
            
        ]))
    }
}
