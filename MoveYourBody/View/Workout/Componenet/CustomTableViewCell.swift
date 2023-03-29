//
//  CustomTableViewCell.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/03/26.
//

import SwiftUI

struct CustomTableViewCell: View {
    var imageName: String
    var exerciseName: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(imageName)
                .resizable()
                .frame(width: 44, height: 44)
            Text(exerciseName)
                .font(.system(size: 25))
                .foregroundColor(.white)
            Spacer()
            Button {
                print("Button Tapped")
            } label: {
                Image(systemName: "info.circle")
                    .font(.largeTitle)
                    .frame(width: 44, height: 44)
            }
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .background(Color.gray.clipShape(RoundedRectangle(cornerRadius: 15)))
        .padding(.horizontal)
    }
}

struct CustomTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomTableViewCell(imageName: "armCircles", exerciseName: "암 서클")
    }
}
