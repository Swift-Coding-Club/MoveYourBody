//
//  WorkoutViewModel.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/30.
//

import Foundation
import AVFoundation

final class WorkoutViewModel: ObservableObject {
    
    @Published var currentImageName = ""
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var workoutImageNamesWithCounts: [(String, Int)] = [("figure.core.training", 10), ("figure.rolling", 15), ("figure.rower", 12)] // 운동 이미지 경로 및 해당 운동 횟수 / 시간
    var currentIndex = 0
    
    init() {
        currentImageName = workoutImageNamesWithCounts[0].0
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch
        { print("Fail to enable session") }
    }
    
    func startWorkout() {
        var count = 1
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            // 3초마다 speakCount로 숫자 세어주기
            self.speakCount(count)
            count += 1
            
            // 설정된 횟수에 도달하면 다음 index로 넘어가기
            if count == self.workoutImageNamesWithCounts[self.currentIndex].1 + 1 {
                count = 1
                self.currentIndex += 1
                // 마지막 index까지 모두 마무리하면 timer 종료 및 변수 초기화
                if self.currentIndex == self.workoutImageNamesWithCounts.count {
                    timer.invalidate()
                    self.currentIndex = 0
                } else {
                    // 마지막이 아니면 이미지 바꾸기
                    self.currentImageName = self.workoutImageNamesWithCounts[self.currentIndex].0
                }
            }
        }
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
        
        let utterance = AVSpeechUtterance(string: koreanCount)
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        speechSynthesizer.speak(utterance)
    }
}
