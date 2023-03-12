//
//  PrepareWorkoutView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/10.
//

import SwiftUI

struct PrepareWorkoutView: View {
    let names: [String]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 15) {
                Text("수행할 운동")
                    .font(.system(size: 50, weight: .bold))
                    .padding(.vertical)
                
                ForEach(names, id: \.self) { names in
                    Text(names)
                        .font(.system(size: 30))
                }
            }
            .foregroundColor(Color("titleForeground"))
        }
    }
}

struct PrepareWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        PrepareWorkoutView(names: ["점핑잭", "벤트오버레터럴레이즈"])
    }
}
