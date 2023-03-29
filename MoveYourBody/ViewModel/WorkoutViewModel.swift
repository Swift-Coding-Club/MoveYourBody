//
//  WorkoutViewModel.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/30.
//

import Foundation
import AVFoundation
import SwiftUI

final class WorkoutViewModel: NSObject, ObservableObject {
    
    @Published var currentImageName = ""
    @Published var currentCount = 0
    @Published var currentExerciseName = ""
    @Published var nextExerciseName = ""
    
    @Published var isExercising = false
    @Published var isPreparingTime = true
    @Published var isWorkoutStopped = false
    @Published var isWorkoutPaused = false
    @Published var isAudioPlayingFinished = false
    @Published var selectedWorkouts: [Workout] = []
    
    private var workouts: [Workout] = [
        Workout(workoutName: "얼터네이팅 덤벨 스윙", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["alternatingDumbbelSwing_base", "alternatingDumbbelSwing_left", "alternatingDumbbelSwing_base", "alternatingDumbbelSwing_right"], bodyPart: .lowerBody),
        Workout(workoutName: "점핑잭", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["jumpingJack_basic", "jumpingJack_left", "jumpingJack_basic", "jumpingJack_right"], bodyPart: .lowerBody),
        Workout(workoutName: "바스켓볼", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["basketBall_1", "basketBall_2"], bodyPart: .lowerBody),
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
                    ["standingCrunch_basic", "standingCrunch_left", "standingCrunch_basic", "standingCrunch_right"], bodyPart: .lowerBody),
        Workout(workoutName: "하프스쿼트 잽 크로스", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["halfSquatJabCross_1", "halfSquatJabCross_2"], bodyPart: .lowerBody),
        
        Workout(workoutName: "밸런스 찹 업", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["balanceChopUp_1", "balanceChopUp_2"], bodyPart: .upperBody),
        Workout(workoutName: "암 서클", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["armCircles"], bodyPart: .upperBody),
        Workout(workoutName: "원 암 트라이셉 킥백", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["oneArmTricepsKickback_1", "oneArmTricepsKickback_2"], bodyPart: .upperBody),
        Workout(workoutName: "스모 사이드 벤드", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["sumoSideBends_1", "sumoSideBends_2"], bodyPart: .upperBody),
        Workout(workoutName: "트라이셉 킥백", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["tricepsKickback_1", "tricepsKickback_2"], bodyPart: .upperBody),
        Workout(workoutName: "굿모닝", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["goodmorning_1", "goodmorning_2"], bodyPart: .upperBody),
        Workout(workoutName: "스탠딩 체스트 플라이", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["standingChestFly_1", "standingChestFly_2"], bodyPart: .upperBody),
        Workout(workoutName: "아놀드 숄더 프레스", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["arnoldShoulderPress_1", "arnoldShoulderPress_2"], bodyPart: .upperBody),
        Workout(workoutName: "벤트 오버 로우 프레스", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["bentOverRowPress_1", "bentOverRowPress_2", "bentOverRowPress_3"], bodyPart: .upperBody),
        Workout(workoutName: "벤트오버 레터럴레이즈", workoutSets: 3, exerciseCountInSet: 12, restTimeBetweenSets: 10, workoutImageNames:
                    ["bentOverLateralRaise_1", "bentOverLateralRaise_2"], bodyPart: .upperBody),
    ]
    
    private var currentImageIndex = 0
    private var currentWorkoutIndex = -1
    
    private var workoutSettingsManager = WorkoutSettingsManager.shared
    private var audioPlayer: AVAudioPlayer!
    
    override init() {
        super.init()
        workouts = workouts.filter({ workout in
            // 상체운동 하고싶다면
            if !workoutSettingsManager.selectUpperBody {
                // 상체운동 파트면 true
                if workout.bodyPart == .upperBody {
                    return true
                }
            }
            
            // 하체운동 하고싶다면
            if !workoutSettingsManager.selectLowerBody {
                // 하체운동 파트면 true
                if workout.bodyPart == .lowerBody {
                    return true
                }
            }
            
            // 둘 다 아니면 return false
            return false
        })
        
        workouts.shuffle() // 랜덤 운동 나올 수 있도록 섞기
        
        // 시간에 따라 운동 갯수 설정하기
        if workoutSettingsManager.selectFiveMinutes {
            workouts.removeSubrange(5...(workouts.count-1))
        } else if workoutSettingsManager.selectSevenMinutes {
            workouts.removeSubrange(7...(workouts.count-1))
        }
        
        workouts.forEach { workout in
            selectedWorkouts.append(workout)
        }
        
        print(selectedWorkouts)
        
        // publish 값 초기화
        currentImageName = workouts[0].workoutImageNames[0]
        currentExerciseName = workouts[0].workoutName
    }
    
    // 한 운동마다 불리는 일회성 메서드
    func startExercise() {
        self.currentCount = 0
        
        // 1.5초마다 이미지 바꾸기
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            if !self.isWorkoutPaused {
                if self.isWorkoutStopped {
                    timer.invalidate()
                    self.currentImageIndex = 0
                    self.stopWorkout()
                }
                
                if self.isPreparingTime {
                    timer.invalidate()
                }
                
                let workoutImagesCount = self.workouts[self.currentWorkoutIndex].workoutImageNames.count
                self.currentImageIndex += 1
                self.currentImageName = self.workouts[self.currentWorkoutIndex].workoutImageNames[self.currentImageIndex % workoutImagesCount]
            }
        }
        
        // 1초마다 숫자 세기
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if !self.isWorkoutPaused {
                if self.isWorkoutStopped {
                    timer.invalidate()
                    self.currentWorkoutIndex = 0
                    self.stopWorkout()
                }
                
                self.currentCount += 1
                
                // 설정 횟수 모두 도달하게 되면 Rest 하고 다음 인덱스로 넘어가기
                if self.currentCount == 45 {
                    // 만약 마지막 운동이었다면 WorkoutSummary뷰 불러올 수 있도록 flag 변수 설정
                    if self.currentWorkoutIndex + 1 == self.workouts.count {
                        timer.invalidate()
                        self.currentCount = 0
                        self.isExercising = false
                        self.isPreparingTime = false
                        self.isWorkoutStopped = true
                        // 마지막 운동이 아니라면 RestTimeView 불러올 수 있도록 flag 변수 설정
                    } else {
                        timer.invalidate()
                        self.currentCount = 0
                        self.isExercising = false
                        self.isPreparingTime = true
                    }
                }
            }
        }
    }
    
    // 다음 운동 준비 시작
    func startPrepare() {
        // 다음 운동 이름 설정
        currentWorkoutIndex += 1
        nextExerciseName = workouts[self.currentWorkoutIndex].workoutName
        currentExerciseName = nextExerciseName
        startDescriptionAudioPlay()
        // 쉬는 시간 15초 세기
        currentCount = 15
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if !self.isWorkoutPaused{
                if self.isWorkoutStopped {
                    self.stopWorkout()
                    timer.invalidate()
                }
                
                if self.currentCount == 0 {
                    self.isPreparingTime = false
                    self.isExercising = true
                    self.currentCount = 0
                    timer.invalidate()
                }
                
                self.currentCount -= 1
            }
        }
    }
    
    // 운동 설명 오디오 재생하기
    func startDescriptionAudioPlay() {
        let audioData: Data
        if NSDataAsset(name: currentExerciseName)?.data == nil {
            audioData = NSDataAsset(name: "굿모닝")!.data
        } else {
            audioData = NSDataAsset(name: currentExerciseName)!.data
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: audioData)
            audioPlayer.delegate = self
            isAudioPlayingFinished = false
            audioPlayer.play()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // 운동 설명 오디오 일시 정지
    func pauseExerciseDescriptionAudio() {
        guard let audioPlayer = audioPlayer else {
            print("audioPlayer 없음")
            return
        }
        audioPlayer.pause()
    }
    
    // 운동 설명 오디오 재생
    func resumeExerciseDescriptionAudio() {
        guard let audioPlayer = audioPlayer else {
            print("AudioPlayer 없음")
            return
        }
        audioPlayer.play()
    }
    
    // 운동 멈추기
    func stopWorkout() {
        isWorkoutStopped = true
        isPreparingTime = false
        isExercising = false
        guard let audioPlayer = audioPlayer else {
            return
        }
        audioPlayer.stop()
    }
}

extension WorkoutViewModel: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isAudioPlayingFinished = true
//        audioPlayer = nil
    }
    
}
