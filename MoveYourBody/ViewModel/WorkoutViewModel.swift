//
//  WorkoutViewModel.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/30.
//

import Foundation

final class WorkoutViewModel: ObservableObject {
    
    @Published var timeRemaining = 30
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var prevWorkoutDescriptionTuple: (String, Int)
    @Published var currentWorkoutDescriptionTuple: (String, Int)
    @Published var nextWorkoutDescriptionTuple: (String, Int)
    
    private var totalTime = 30
    private var workoutDescriptionTuples: [(String, Int)] = [("안녕하세요", 3), ("2초입니다", 2), ("여긴5초입니다", 5), ("여긴몇초게요?4", 4), ("여긴3초입니다", 3)]
    private var currentIndex = 0
    
    init() {
        prevWorkoutDescriptionTuple = workoutDescriptionTuples[0]
        currentWorkoutDescriptionTuple = workoutDescriptionTuples[1]
        nextWorkoutDescriptionTuple = workoutDescriptionTuples[2]
    }
    
    func countDownString(from date: Date, until nowDate: Date) -> String {
        let calender = Calendar(identifier: .gregorian)
        let components = calender
            .dateComponents([.second], from: nowDate, to: date)
        
        return String(format: "%02ds", components.second ?? 00)
    }
    
    func counterProgress() -> CGFloat {
        return (CGFloat(totalTime - timeRemaining) / CGFloat(totalTime))
    }
    
    func delayTime() async {
        while currentIndex < workoutDescriptionTuples.count - 1 {
            try? await Task.sleep(nanoseconds: UInt64(currentWorkoutDescriptionTuple.1 * 1_000_000_000))
            updateWorkoutDescriptions()
        }
    }
    
    func updateWorkoutDescriptions() {
        if currentIndex < workoutDescriptionTuples.count - 1 {
            currentIndex += 1
            prevWorkoutDescriptionTuple = workoutDescriptionTuples[currentIndex-1]
            currentWorkoutDescriptionTuple = workoutDescriptionTuples[currentIndex]
            if currentIndex + 1 < workoutDescriptionTuples.count {
                nextWorkoutDescriptionTuple = workoutDescriptionTuples[currentIndex+1]
            } else {
                nextWorkoutDescriptionTuple = ("", 0)
            }
        }
    }
}
