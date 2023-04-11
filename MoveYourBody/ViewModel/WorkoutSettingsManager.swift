//
//  WorkoutSettingsViewModel.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/16.
//

import Foundation
import SwiftUI

final class WorkoutSettingsManager: ObservableObject {
    static let shared = WorkoutSettingsManager()
    private init() {}
    
    @AppStorage("selectUpper") var selectUpperBody: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    @AppStorage("selectLower") var selectLowerBody: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    @AppStorage("fiveMinutes") var selectFiveMinutes: Bool = true {
        didSet {
            objectWillChange.send()
        }
    }
    
    @AppStorage("sevenMinutes") var selectSevenMinutes: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
}
