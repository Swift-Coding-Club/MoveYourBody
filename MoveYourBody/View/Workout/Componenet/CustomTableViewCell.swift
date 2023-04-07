//
//  CustomTableViewCell.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/26.
//

import SwiftUI

struct CustomTableViewCell: View {
    var imageNames: [String]
    var exerciseName: String
    var instructions: String
    var considerations: String
   
    @State private var isPresented = false
    
    var body: some View {
        HStack(spacing: 15) {
            Image(imageNames[0])
                .resizable()
                .frame(width: 44, height: 44)
            Text(exerciseName)
                .font(.system(size: 25))
                .foregroundColor(.white)
            Spacer()
            Button {
                isPresented = true
            } label: {
                Image(systemName: "info.circle")
                    .font(.largeTitle)
                    .frame(width: 44, height: 44)
            }
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(Color.gray.clipShape(RoundedRectangle(cornerRadius: 15)))
        .padding(.horizontal)
        .sheet(isPresented: $isPresented) {
            ExerciseInstructionSheetView(exerciseName: exerciseName, imageNames: imageNames, instruction: instructions, consideration: considerations)
        }
    }
}

struct CustomTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomTableViewCell(imageNames: ["armCircles"], exerciseName: "암 서클", instructions: Constants.squatInstructions, considerations: Constants.squatConsiderations)
    }
}
