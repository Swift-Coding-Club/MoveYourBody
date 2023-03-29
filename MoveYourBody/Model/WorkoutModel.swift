//
//  WorkoutModel.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/08.
//

import Foundation

enum BodyParts {
    case upperBody
    case lowerBody
}

struct Workout: Identifiable, Hashable {
    var id = UUID().uuidString
    let workoutName: String // 운동 이름
    let workoutSets: Int // 몇 세트 운동할지 정하기
    let exerciseCountInSet: Int // 한 세트당 몇 번 운동할지 정하기
    let restTimeBetweenSets: Int // 세트 사이 쉬는 시간 설정
    let workoutImageNames: [String] // 운동 이미지 이름들
    let bodyPart: BodyParts
}
