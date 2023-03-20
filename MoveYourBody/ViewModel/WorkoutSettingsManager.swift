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
    
    @AppStorage("toggle1") var didTap1: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    @AppStorage("toggle2") var didTap2: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    @AppStorage("toggle3") var didTap3: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    @AppStorage("toggle4") var didTap4: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    @AppStorage("toggle5") var didTap5: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    @AppStorage("toggle6") var didTap6: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    @AppStorage("toggle7") var didTap7: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
}
