//
//  WorkoutModel.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/08.
//

import Foundation

struct Workout {
    let workoutName: String // 운동 이름
    let workoutSets: Int // 몇 세트 운동할지 정하기
    let exerciseCountInSet: Int // 한 세트당 몇 번 운동할지 정하기
    let restTimeBetweenSets: Int // 세트 사이 쉬는 시간 설정
    let workoutImageNames: [String] // 운동 이미지 이름들
}