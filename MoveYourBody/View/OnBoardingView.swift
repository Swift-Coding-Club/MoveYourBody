//
//  OnBoardingView.swift
//  MoveYourBody
//
//  Created by 안윤진 on 2023/02/17.
//

import SwiftUI

enum Walkthrough{
    static let currentPage = 1
}


struct OnBoardingView: View{
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("signed_in") var currentUserSignedIn: Bool = true
    var body: some View{
        ZStack{
            if currentPage == 1 {
                ScreenView(image: "figure.run", title: "운동 설정에서 하고 싶지 않은 동작이나 운동 시간을 설정할 수 있습니다.").transition(.scale)}
                
            if currentPage == 2{
                ScreenView(image: "gearshape.fill", title: "알림 설정에서 푸시 알림을 설정할 수 있습니다. 매일 운동하고 싶은 시간에 알림을 맞춰보세요").transition(.scale)}
            if currentPage == 3{
                ScreenView2(image: "start_icon", title: "지금 바로 운동을 시작해보세요.").transition(.scale)
            }
            if currentPage == 4{
                MainScreen()
            }
            
           
        }
        
    }
}


struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}


struct ScreenView: View {
    var image: String
    var title: String
    
    @AppStorage("currentPage") var currentPage:Int = Walkthrough.currentPage
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                HStack{
                    if currentPage == 1{
                        Text("환영합니다!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .kerning(1.4)
                    }else{}
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage = 4
                        }
                    }, label: {
                        Text("Skip")
                            .fontWeight(.semibold)
                            .kerning(1.2)
                    })
                    
                }
                
                .foregroundColor(.black)
                .padding()
                Spacer(minLength: 0)
                
                Image(systemName:image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .kerning(1.3)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 80)
            }.background(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        
        .overlay(Button(action: {
            //뷰 변경
            withAnimation(.easeInOut){
                if currentPage <= totalPages{
                    currentPage += 1
                }else{
                    //앱 테스트 용도
                    currentPage = 1
                }
            }
        }, label: {
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .frame(width:60, height: 60)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(
                    ZStack{
                        Circle()
                            .stroke( Color.black.opacity(0.04),lineWidth:4)
                        Circle()
                            .trim(from: 0, to: CGFloat(currentPage)/CGFloat(totalPages))
                            .stroke(Color.white, lineWidth: 4)
                            .rotationEffect(.init(degrees: -90))
                    }
                        .padding(-15)
                )
        })
                 ,alignment: .bottom)
    }
}
struct ScreenView2: View {
    var image: String
    var title: String
    
    @AppStorage("currentPage") var currentPage:Int = Walkthrough.currentPage
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                HStack{
                    if currentPage == 1{
                        Text("환영합니다!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .kerning(1.4)
                    }else{}
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage = 4
                        }
                    }, label: {
                        Text("Skip")
                            .fontWeight(.semibold)
                            .kerning(1.2)
                    })
                    
                }
                
                .foregroundColor(.black)
                .padding()
                Spacer(minLength: 0)
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .kerning(1.3)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 80)
            }.background(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
    .overlay(Button(action: {
        //뷰 변경
        withAnimation(.easeInOut){
            if currentPage <= totalPages{
                currentPage += 1
            }else{
                //앱 테스트 용도
                currentPage = 1
            }
        }
    }, label: {
        Image(systemName: "chevron.right")
            .font(.system(size: 20, weight: .semibold))
            .foregroundColor(.black)
            .frame(width:60, height: 60)
            .background(Color.white)
            .clipShape(Circle())
            .overlay(
                ZStack{
                    Circle()
                        .stroke( Color.black.opacity(0.04),lineWidth:4)
                    Circle()
                        .trim(from: 0, to: CGFloat(currentPage)/CGFloat(totalPages))
                        .stroke(Color.white, lineWidth: 4)
                        .rotationEffect(.init(degrees: -90))
                }
                    .padding(-15)
            )
    })
             ,alignment: .bottom)
    }
}
var totalPages = 3
