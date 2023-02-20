//
//  VideoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/17.
//

import SwiftUI

struct WorkoutView: View {
    
    @Environment(\.scenePhase) var scenePhase   // 앱이 백그라운드에 있는지, 포어그라운드에 있는지 알기 위한 변수
    @StateObject private var workoutViewModel = WorkoutViewModel()
    @State private var startCount = true    // 카운트 시작을 결정하는 변수
    @State private var isAppActive = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack: some View{
        Button(action:{self.presentationMode.wrappedValue.dismiss()}){
            HStack{
                Image("go-back")
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 70) {
//                secondCount()
//                    .onReceive(workoutViewModel.timer) { time in
//                        guard isAppActive else { return }
//
//                        if workoutViewModel.timeRemaining > 0, startCount {
//                            workoutViewModel.timeRemaining -= 1
//                        }
//                    }
//                    .onChange(of: scenePhase) { newPhase in // 앱이 포어그라운드에 있을 때만 카운터 동작
//                        if newPhase == .active {
//                            isAppActive = true
//                        } else {
//                            isAppActive = false
//                        }
//                    }
                exerciseImage()
//                showDescription()
            }
            .onAppear() {
                workoutViewModel.startWorkout()
            }
        }
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
    
//    @ViewBuilder
//    func secondCount() -> some View {
//        HStack {
//            Text("\(workoutViewModel.timeRemaining)")
//                .font(.system(size: 80, weight: .bold))
//        }
//        .foregroundColor(.white)
//    }
    
    @ViewBuilder
    func exerciseImage() -> some View {
        ZStack {
            Image(systemName: workoutViewModel.currentImageName)
                .font(.system(size: 150))
                .foregroundColor(.white)
            
            Circle()
                .stroke(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 10)
                .frame(width: 250, height: 250)
            
//            Circle()
//                .trim(from: 0, to: workoutViewModel.counterProgress())
//                .stroke(Color.red, lineWidth: 10)
//                .frame(width: 250, height: 250)
//                .rotationEffect(.degrees(-90))
//                .animation(.easeInOut(duration: 0.05), value: workoutViewModel.timeRemaining)
        }
    }
    
//    @ViewBuilder
//    func showDescription() -> some View {
//        ScrollView() {
//            VStack(spacing: 20) {
//                Text(workoutViewModel.prevWorkoutDescriptionTuple.0)
//                    .font(.system(size: 25, weight: .heavy))
//                    .opacity(0.8)
//
//                Text(workoutViewModel.currentWorkoutDescriptionTuple.0)
//                    .font(.system(size: 40, weight: .bold))
//
//                Text(workoutViewModel.nextWorkoutDescriptionTuple.0)
//                    .font(.system(size: 25, weight: .heavy))
//                    .opacity(0.8)
//            }
//            .foregroundColor(.white)
//            .task {
//                print("called")
//                await workoutViewModel.delayTime()
//            }
//        }
//    }
    
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
