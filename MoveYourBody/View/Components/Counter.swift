//
//  ShowExercise.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/15.
//

import SwiftUI

let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

struct Counter: View {
    
    @State var counter = 0
    var countTo: Int = 30 // 30초까지 세기
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            timerWithProgressBar()
            clock()
        }
        .onReceive(timer) { time in
            if (self.counter < self.countTo) {
                self.counter += 1
            }
        }
        
    }
    
    @ViewBuilder
    func timerWithProgressBar() -> some View {
        ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 250, height: 250)
                .overlay(Circle().stroke(Color.green, lineWidth: 25))
            
            Circle()
                .fill(Color.clear)
                .frame(width: 250, height: 250)
                .overlay(
                    Circle()
                        .trim(from: 0, to: progress())
                        .stroke(style: StrokeStyle(lineWidth: 25, lineCap: .round, lineJoin: .round))
                )
                .foregroundColor((completed() ? Color.orange : Color.red))
                .animation(.easeInOut(duration: 0.2), value: counter)
        }
    }
    
    @ViewBuilder
    func clock() -> some View {
        Text(counterToMinutes())
            .font(.system(size: 60))
            .fontWeight(.black)
            .foregroundColor(.white)
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        
        return "\(seconds)"
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        Counter()
    }
}
