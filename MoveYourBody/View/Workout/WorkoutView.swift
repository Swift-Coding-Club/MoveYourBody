//
//  VideoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/17.
//

import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(insertion: .move(edge:.trailing).combined(with: .opacity), removal: .scale.combined(with: .opacity))
    }
}

struct WorkoutView: View {
    
    @StateObject private var workoutViewModel = WorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // 뒤로가기 버튼
    var btnBack: some View{
        Button(action:{
            workoutViewModel.stopWorkout()
            self.presentationMode.wrappedValue.dismiss()}
        ){
            HStack{
                Image("go-back")
            }
        }
    }
    
    // MARK: - body
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            // 운동 중일 때
            if workoutViewModel.isWorkoutStarted {
                // 쉬는 시간이 아니면 운동 뷰 보이기
                if !workoutViewModel.isRestTime {
                    ExerciseView(currentKoreanCount: $workoutViewModel.currentKoreanCount, exerciseName: workoutViewModel.currentExerciseName, imageName: workoutViewModel.currentImageName)
                        .task {
                            workoutViewModel.startExercise()
                        }
                    // 쉬는 시간이면 쉬는 시간 뷰 보이기
                } else {
                    RestTimeView(nextExercise: workoutViewModel.nextExerciseName, leftSeconds: $workoutViewModel.currentCount)
                        .task {
                            workoutViewModel.startRest()
                        }
                }
            // 운동 중이 아닐 때
            } else {
                // 운동이 끝난게 아니라면 준비중 화면
                if !workoutViewModel.isWorkoutEnded {
                    PrepareWorkoutView(names: workoutViewModel.workoutNames)
                        .task {
                            workoutViewModel.prepareWorkout()
                        }
                    // 운동이 끝났다면 결과화면
                } else {
                    WorkoutSummaryView()
                }
            }
        }
        
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
