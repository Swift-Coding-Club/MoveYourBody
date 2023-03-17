//
//  WorkoutViewModel.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/30.
//

import Foundation
import AVFoundation
import SwiftUI

final class WorkoutViewModel: ObservableObject {
    
    @Published var currentImageName = ""
    @Published var currentKoreanCount = "준비"
    @Published var currentCount = 10
    @Published var currentExerciseName = ""
    @Published var workoutNames = [String]()
    @Published var isWorkoutStopped = false
    @Published var nextExerciseName = ""
    @Published var isRestTime = false
    @Published var isWorkoutStarted = false
    @Published var isWorkoutEnded = false
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    private var currentImageIndex = 0
    private var currentWorkoutIndex = 0
    
    private var workouts: [Workout] = [
        Workout(workoutName: "벤트오버 레터럴레이즈", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["bentOverLateralRaise_1", "bentOverLateralRaise_2"], bodyPart: .upperBody),
        Workout(workoutName: "점핑잭", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["jumpingJack_basic", "jumpingJack_left", "jumpingJack_basic", "jumpingJack_right"], bodyPart: .lowerBody),
        Workout(workoutName: "바스켓볼", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["basketBall_1", "basketBall_2"], bodyPart: .lowerBody),
        Workout(workoutName: "굿모닝", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["goodmorning_1", "goodmorning_2"], bodyPart: .upperBody),
        Workout(workoutName: "하이 니", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["highKnee_1", "highKnee_2"], bodyPart: .lowerBody),
        Workout(workoutName: "런지", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["lunge_1", "lunge_2"], bodyPart: .lowerBody),
        Workout(workoutName: "사이드 런지", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["sideLunge_base", "sideLunge_left", "sideLunge_base", "sideLunge_right"], bodyPart: .lowerBody),
        Workout(workoutName: "스케이터 토 터치", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["skaterToeTouch_1", "skaterToeTouch_2"], bodyPart: .lowerBody),
        Workout(workoutName: "스쿼트", workoutSets: 2, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["squat_1", "squat_2"], bodyPart: .lowerBody),
        Workout(workoutName: "스탠딩 크런치", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["standingCrunch_basic", "standingCrunch_left", "standingCrunch_basic", "standingCrunch_right"], bodyPart: .lowerBody)
    ]
    
    init() {
        
        workouts = workouts.filter({ workout in
            // 상체운동 하고싶다면
            if !WorkoutSettingsManager.shared.didTap4 {
                // 상체운동 파트면 true
                if workout.bodyPart == .upperBody {
                    return true
                }
            }
            
            // 하체운동 하고싶다면
            if !WorkoutSettingsManager.shared.didTap5 {
                // 하체운동 파트면 true
                if workout.bodyPart == .lowerBody {
                    return true
                }
            }
            
            // 둘 다 아니면 return false
            return false
        })
        
        print("noUpperBody : \(WorkoutSettingsManager.shared.didTap4)")
        print("noLowerBody : \(WorkoutSettingsManager.shared.didTap5)")
        print(workouts)
        
        workouts.shuffle() // 랜덤 운동 나올 수 있도록 섞기
        
        // publish 값 초기화
        currentImageName = workouts[0].workoutImageNames[0]
        currentExerciseName = workouts[0].workoutName
        
        // 셔플된 workout 이름들 배열에 넣기
        for workout in workouts {
            workoutNames.append(workout.workoutName)
        }
        
        // tts 위한 AVAudioSession 초기화
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch
        {
            print("Fail to enable session")
        }
    }
    
    // 운동 준비하기
    func prepareWorkout() {
        // 5초 준비 화면 보여준 후 운동 시작하기
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
            self.isWorkoutStarted = true
        }
    }
    
    // 한 운동마다 불리는 일회성 메서드
    func startExercise() {
        var count = 1
        
        // 1.5초마다 이미지 바꾸기
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            if self.isWorkoutStopped {
                timer.invalidate()
                self.currentImageIndex = 0
            }
            
            let workoutImagesCount = self.workouts[self.currentWorkoutIndex].workoutImageNames.count
            self.currentImageIndex += 1
            self.currentImageName = self.workouts[self.currentWorkoutIndex].workoutImageNames[self.currentImageIndex % workoutImagesCount]
        }
        
        // 3초마다 숫자 세기
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            if self.isWorkoutStopped {
                timer.invalidate()
                self.currentWorkoutIndex = 0
                self.isWorkoutStopped = false
            }
            
            self.speakCount(count)
            count += 1
           
            // 설정 횟수 모두 도달하게 되면 Rest 하고 다음 인덱스로 넘어가기
            if count == self.workouts[self.currentWorkoutIndex].exerciseCountInSet + 1 {
                // 만약 마지막 운동이었다면 WorkoutSummary뷰 불러올 수 있도록 flag 변수 설정
                if self.currentWorkoutIndex + 1 == self.workouts.count {
                    timer.invalidate()
                    self.isWorkoutStarted = false
                    self.isWorkoutEnded = true
                // 마지막 운동이 아니라면 RestTimeView 불러올 수 있도록 flag 변수 설정
                } else {
                    timer.invalidate()
                    self.currentKoreanCount = "준비"
                    self.isRestTime = true
                }
            }
        }
    }
   
    // 쉬는 시간 시작
    func startRest() {
        // 다음 운동 이름 설정
        currentWorkoutIndex += 1
        nextExerciseName = workoutNames[currentWorkoutIndex]
        currentExerciseName = nextExerciseName
       
        // 쉬는 시간 10초 세기
        currentCount = 10
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.currentCount == 0 {
                timer.invalidate()
                self.isRestTime = false
            }
            self.currentCount -= 1
        }
    }
    
    // 운동 멈추기
    func stopWorkout() {
        isWorkoutStopped = true
        speechSynthesizer.pauseSpeaking(at: .immediate)  // speaking 중지
    }
    
    /// count로 들어오는 숫자 이름을 디바이스 스피커로 출력
    /// - Parameter count: 출력할 숫자
    func speakCount(_ count: Int) {
        // 추후 숫자를 고유어 한글로 변환해주는 extension 제작해보자
        print(count)
        var koreanCount: String
        
        switch count {
        case 1:
            koreanCount = "하나"
        case 2:
            koreanCount = "둘"
        case 3:
            koreanCount = "셋"
        case 4:
            koreanCount = "넷"
        case 5:
            koreanCount = "다섯"
        case 6:
            koreanCount = "여섯"
        case 7:
            koreanCount = "일곱"
        case 8:
            koreanCount = "여덟"
        case 9:
            koreanCount = "아홉"
        case 10:
            koreanCount = "열"
        case 11:
            koreanCount = "열하나"
        case 12:
            koreanCount = "열둘"
        case 13:
            koreanCount = "열셋"
        case 14:
            koreanCount = "열넷"
        case 15:
            koreanCount = "열다섯"
        default:
            koreanCount = ""
        }
        
        currentKoreanCount = koreanCount
        let utterance = AVSpeechUtterance(string: koreanCount)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        speechSynthesizer.speak(utterance)
    }
}
