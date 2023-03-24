//
//  VideoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/17.
//

import SwiftUI

struct WorkoutView: View {
    
    @StateObject var workoutViewModel = WorkoutViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isViewTapped = false
    
    // 뒤로가기 버튼
    var btnBack: some View {
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
                    PrepareExerciseView(currentCount: $workoutViewModel.currentCount, nextExercise: $workoutViewModel.nextExerciseName)
                        .task {
                            workoutViewModel.startPrepare()
                        }
                } else {
                    WorkoutSummaryView()
                }
            }
            
            if isViewTapped {
                VStack {
                    HStack {
                        backButton()
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                            .ignoresSafeArea()
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        .statusBarHidden(true)
        .onTapGesture {
            self.isViewTapped.toggle()
        }
        
//        .navigationBarItems(leading: btnBack)
//        .navigationBarBackButtonHidden(true)
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
