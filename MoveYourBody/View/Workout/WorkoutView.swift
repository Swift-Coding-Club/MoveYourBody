//
//  VideoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/17.
//

import SwiftUI

extension Animation {
    static func spring() -> Animation {
        Animation.spring(dampingFraction: 0.8)
            .speed(2)
    }
}

struct WorkoutView: View {
    
    @StateObject var workoutViewModel = WorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isViewTapped = false
    
    // MARK: - body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                // 운동 중이면
                if workoutViewModel.isExercising {
                    // 운동 뷰
                    ExerciseView(workoutViewModel: workoutViewModel)
                        .task {
                            workoutViewModel.startExercise()
                        }
                } else {
                    // 준비 중이면
                    if workoutViewModel.isPreparingTime {
                        // 운동 준비 뷰
                        PrepareExerciseView(currentCount: $workoutViewModel.currentCount, nextExercise: $workoutViewModel.nextExerciseName)
                            .task {
                                workoutViewModel.startPrepare()
                            }
                    } else {
                        // 둘 다 아니면 결과 뷰
                        WorkoutSummaryView()
                    }
                }
                
                // 운동 중 아무곳이나 탭하면
                if isViewTapped {
                    VStack {
                        HStack {
                            // 뒤로가기 버튼 보이기
                            backButton()
                                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                                .ignoresSafeArea()
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    CustomBottomSheet {
                        ExerciseListModalView(workouts: $workoutViewModel.selectedWorkouts)
                    }
                    .transition(.moveFromBottom)
                    .zIndex(1)
                }
            }
        }
        .statusBarHidden(true)
        .onTapGesture {
            withAnimation(.spring()) {
                self.isViewTapped.toggle()
            }
            self.workoutViewModel.isWorkoutPaused.toggle()
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func backButton() -> some View {
        Button(action:{
            workoutViewModel.stopWorkout()
            self.presentationMode.wrappedValue.dismiss()}
        ){
            HStack{
                Image("go-back")
            }
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
