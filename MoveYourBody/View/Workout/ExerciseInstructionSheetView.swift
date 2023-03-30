//
//  ExerciseDescriptionSheetView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/29.
//

import SwiftUI

struct ExerciseInstructionSheetView: View {
    
    @State var currentImageIndex = 0
    @State var currentImageName = ""
    
    var exerciseName: String
    var imageNames: [String]
    var instruction: String
    var consideration: String
    
    var body: some View {
        ZStack {
            Color("sheetBackground")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Text(exerciseName)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    Image(currentImageName)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .task {
                            currentImageName = imageNames[0]
                            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
                                let imagesCount = imageNames.count
                                self.currentImageIndex += 1
                                currentImageName = imageNames[self.currentImageIndex % imagesCount]
                            }
                        }
                    
                    Text(instruction)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                        .lineSpacing(5)
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    
                    Text("주의 사항")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(consideration)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                        .lineSpacing(5)
                        .padding(EdgeInsets(top: 20, leading: 5, bottom: 0, trailing: 5))
                }
            }
        }
    }
}

struct ExerciseDescriptionSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseInstructionSheetView(exerciseName: "하이 니", imageNames: ["highKnee_1", "highKnee_2"], instruction: Constants.alternativeDumbbelSwingInstructions, consideration: Constants.alternativeDumbbelSwingConsiderations)
    }
}
