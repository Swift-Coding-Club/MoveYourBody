//
//  PrepareWorkoutView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/02/21.
//

import SwiftUI

struct PrepareWorkoutView: View {
    @StateObject var workoutViewModel: WorkoutViewModel = WorkoutViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("수행할 운동 목록")
                ForEach(workoutViewModel.workoutNames, id: \.self) { names in
                    Text(names)
                }
            }
            .font(.system(size: 50, weight: .bold))
            .foregroundColor(.white)
        }
    }
}

struct PrepareWorkoutView_Previews: PreviewProvider {
    
    static var previews: some View {
        PrepareWorkoutView()
    }
}
