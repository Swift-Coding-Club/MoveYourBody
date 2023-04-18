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
//    @AppStorage("signed_in") var currentUserSignedIn: Bool = true
    var body: some View{
        ZStack{
            if currentPage == 1 {
                ScreenView(title: "").transition(.scale)}
                
            if currentPage == 2{
                ScreenView(title: "설정을 통해\n맞춤운동을 생활화하세요").transition(.scale)}
            if currentPage == 3{
                ScreenView(title: "버튼을 클릭해 운동을 \n바로 시작하세요").transition(.scale)
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
    var title: String
    
    @AppStorage("currentPage") var currentPage:Int = Walkthrough.currentPage
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    if currentPage == 1{
                        titleOnboarding()
                    }
                    else if currentPage == 2{
                        settingsOnboarding()
                    }
                    else if currentPage == 3{
                        startOnboarding()
                    }
                    }.background(.black)
                    .frame(width:200,height:400)
                
            }.background(.black)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
              

            VStack(spacing:20){
                Button(action:{
                    currentPage = 4
                },label:{
                    Text("skip")
                }).frame(maxWidth: .infinity,alignment: .trailing)
                    .padding(.trailing,30)
               
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                
                Spacer()
                
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
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
            .padding(.bottom,30)
        }.foregroundColor(.white)
            .background(.black)
        
        
    }
    

}

struct settingsOnboarding: View{
    var body: some View{
        ZStack{
            Image("mockupImg")
                .resizable()
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "figure.run")
                        .font(.system(size: 25, weight: .regular))
                        .foregroundColor(.black)
                        .foregroundStyle(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding(.bottom,30)
                        .padding(.leading,30)
                    Spacer()
                    
                    
                    Image(systemName: "bell.fill")
                        
                        .font(.system(size: 20, weight: .regular))
                     .foregroundColor(.black)
                        .foregroundStyle(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .padding(.bottom,30)
                        .padding(.trailing,30)
                    
                }
                
            }
        }
    }
}


struct startOnboarding: View{
    var body: some View{
        ZStack{
            Image("mockupImg")
                .resizable()
            VStack{
                Spacer()
                VStack{
                    Text("START")
                        .font(.system(size: 20, weight: .bold))
                        .padding()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .clipShape(Circle())
                    
                    Image("clickImg")
                       .resizable()
                       .frame(width: 100, height: 100)
                    
                }.padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                Spacer()
                
            }
        }
    }
}
struct titleOnboarding: View{
    var body: some View{
        ZStack{
            VStack{
                Spacer()
                VStack {
                    Text("MOVE")
                        .font(.system(size: 50, weight: .heavy))
                        .offset(x: -20)
                    Text("YOUR")
                        .font(.system(size: 45, weight: .bold))
                        .offset(x: 25)
                    Text("BODY")
                        .font(.italic(.system(size: 70, weight: .heavy))())
                        .offset(x: 20)
                }
                .foregroundStyle(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
                Spacer()
                
            }
        }
    }
}
var totalPages = 3
