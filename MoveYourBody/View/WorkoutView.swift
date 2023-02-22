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
    @State private var startCount = true    // 카운트 시작을 결정하는 변수
    @State private var isAppActive = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isWorkoutStarted = false
    
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
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
           
            if isWorkoutStarted {
                VStack(spacing: 70) {
                    showExerciseName()
                    exerciseImage()
                    showCounts()
                        .frame(height: 50)
                }
                .onAppear() {
                    workoutViewModel.startWorkout()
                }
                .onDisappear() {
                    workoutViewModel.stopWorkout()
                }
                .transition(.moveAndFade)
                
            } else {
                prepareWorkout()
                    .task {
                        workoutViewModel.prepareWorkout()
                        // 5초간 수행할 운동 보여준 후 운동 시작
                        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
                            Task{ @MainActor in
                                isWorkoutStarted = true
                            }
                            timer.invalidate()
                        }
                    }
            }
            
        }
        
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func showExerciseName() -> some View {
        Text(workoutViewModel.currentExerciseName)
            .font(.system(size: 50, weight: .bold))
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    func exerciseImage() -> some View {
        ZStack {
            Image(systemName: workoutViewModel.currentImageName)
                .font(.system(size: 150))
                .foregroundColor(.white)
            
            Circle()
                .stroke(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 10)
                .frame(width: 250, height: 250)
        }
    }
    
    @ViewBuilder
    func showCounts() -> some View {
        Text(workoutViewModel.currentKoreanCount)
            .font(.system(size: 50, weight: .semibold))
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    func prepareWorkout() -> some View {
        VStack {
            Text("수행할 운동")
                .font(.system(size: 50, weight: .semibold))
                .padding(.vertical)
            
            ForEach(workoutViewModel.workoutNames, id: \.self) { names in
                Text(names)
                    .font(.system(size: 30, weight: .regular))
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            }
        }
        .foregroundColor(.white)
        .transition(.moveAndFade)
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
