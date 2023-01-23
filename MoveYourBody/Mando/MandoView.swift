//
//  MandoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/12.
//

import SwiftUI

struct MandoView: View {
    var body: some View {
        ZStack(alignment:.top) {
            Color("background")
                .ignoresSafeArea()
            VStack(spacing:40){
                HStack(){
                        navHomeButton()
                        mainTitle()
                    }
                    questionFirst()
                    HStack{
                        Button("서서 운동"){}
                            .buttonStyle(OutlineButton())
                        Button("앉아서 운동"){}
                            .buttonStyle(OutlineButton())
                    }
                    questionSecond()
                    VStack{
                        HStack{
                            Button("플랭크"){}
                                .buttonStyle(OutlineButton())
                            Button("허리 굽히기"){}
                                .buttonStyle(OutlineButton())
                            Button("런지"){}
                                .buttonStyle(OutlineButton())
                        }
                        HStack{
                            Button("무릎 굽히기"){}
                                .buttonStyle(OutlineButton())
                            Button("스쿼트"){}
                                .buttonStyle(OutlineButton())
                            Button("다리 찢기"){}
                                .buttonStyle(OutlineButton())
                        }
                    }
                
                questionThird()
                VStack{
                    HStack{
                        Button("3분 이하"){}
                            .buttonStyle(OutlineButton())
                        Button("5분"){}
                            .buttonStyle(OutlineButton())
                        Button("5분 이상"){}
                            .buttonStyle(OutlineButton())
                    }}
                }
            }
        
    }
    

    @ViewBuilder
    func mainTitle() -> some View {
        VStack {
            Text("운동 설정")
                .font(.system(size: 35, weight: .heavy))
                .multilineTextAlignment(.center)
        }
        .foregroundColor(Color("titleForeground"))
    }
    
    @ViewBuilder
    func questionSecond() -> some View {
        VStack {
            Text("하고 싶지 않은 동작이 있나요?")
                .font(.system(size: 25, weight: .heavy))
                .multilineTextAlignment(.leading)
        }
        .foregroundColor(Color("titleForeground"))
    }
    
    @ViewBuilder
    func questionFirst() -> some View {
        VStack {
            Text("선호하는 운동 방식이 있나요?")
                .font(.system(size: 25, weight: .heavy))
                .multilineTextAlignment(.leading)
        }
        .foregroundColor(Color("titleForeground"))
    }
    
    @ViewBuilder
    func questionThird() -> some View {
        VStack {
            Text("1회에 얼마나 운동하고 싶나요?")
                .font(.system(size: 25, weight: .heavy))
                .multilineTextAlignment(.leading)
        }
        .foregroundColor(Color("titleForeground"))
    }
    
    
    @ViewBuilder
    func navHomeButton() -> some View {
        Button {
            
        } label: {
            Image("back-button")
        }
    }
    
    @ViewBuilder
    func optionButton() -> some View {
        Button("스쿼트") {}
            .foregroundColor(.black)
            .padding()
            .background(.white)
            .cornerRadius(8)
    }
    
    struct OutlineButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            
            configuration
                .label
                .foregroundColor(configuration.isPressed ? .green : .white)
                .padding()
                .background(
                    RoundedRectangle(
                        cornerRadius: 8,
                        style: .continuous
                    ).stroke(configuration.isPressed ? .green : .white)
            )
        }
    }
}

struct MandoView_Previews: PreviewProvider {
    static var previews: some View {
        MandoView()
    }
}
