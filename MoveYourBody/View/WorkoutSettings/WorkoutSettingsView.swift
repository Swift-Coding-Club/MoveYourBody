//
//  MandoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/12.


import SwiftUI

struct WorkoutSettingsView: View {
    @StateObject var settings = WorkoutSettingsManager.shared
    
    //Onboarding Screen을 띄우기 위한 변수
    @AppStorage("firstVisit") var isFirstTimeVisited = true
    
    //btnBack을 눌렀을 때 메인화면으로 돌아가기 위함.
    //ios15에서 presentationMode는 deprecated됨
    @Environment(\.dismiss) private var dismiss
    
    //정의하였으나 사용법을 모름
    let gradient2 = LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing)
    
    //메인 화면으로 돌아가는 버튼, 네비게이션이 아닌 현재 화면을 지워서 돌아감
    @State private var buttonBackColor: Color = Color("neongreen")
    
    var btnBack: some View{
        Button(action:{dismiss()}){
            HStack{
                Image(systemName: "chevron.left")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
    
    //네비게이션 타이틀의 경우 색상 지정을 위해 별도의 초기화가 필요해서 작성
    init() {
        // Large Font일 때 사용
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // displayMode = .inline일 때 사용
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View{
        NavigationView{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                VStack (spacing:80){
                    VStack(spacing: 20){
                        Text("하고 싶지 않은 동작이 있나요?")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        HStack{
                            Button(action:{
                                settings.selectUpperBody.toggle()
                                if settings.selectUpperBody == true && settings.selectLowerBody == true {
                                    settings.selectLowerBody.toggle()
                                }
                            }){
                                Text("상체")
                                    .foregroundColor(settings.selectUpperBody ? .black: .white)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                    )
                            }
                            .background(LinearGradient(gradient: settings.selectUpperBody ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            
                            Button(action:{
                                settings.selectLowerBody.toggle()
                                if settings.selectUpperBody == true && settings.selectLowerBody == true {
                                    settings.selectUpperBody.toggle()
                                }
                            }){
                                Text("하체")
                                    .foregroundColor(settings.selectLowerBody ? .black: .white)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                    )
                            }
                            .background(LinearGradient(gradient: settings.selectLowerBody ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)                        }
                    }
                    
                    VStack( spacing: 20){
                        Text("1회 운동 시간을 정하세요.")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        
                        HStack{
                            Button(action:{
                                settings.selectFiveMinutes.toggle()
                                if(settings.selectFiveMinutes == true && settings.selectSevenMinutes == true){
                                    settings.selectSevenMinutes.toggle()
                                }
                            }){
                                Text("5분")
                                    .foregroundColor(settings.selectFiveMinutes ? .black: .white)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                    )
                            }
                            .background(LinearGradient(gradient: settings.selectFiveMinutes ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            
                            Button(action:{
                                settings.selectSevenMinutes.toggle()
                                if(settings.selectFiveMinutes == true && settings.selectSevenMinutes == true){
                                settings.selectFiveMinutes.toggle()
                            }
                            }){
                                Text("7분")
                                    .foregroundColor(settings.selectSevenMinutes ? .black: .white)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                    )
                            }
                            .background(LinearGradient(gradient: settings.selectSevenMinutes ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                        }
                        
                    }
                    
                }
                .navigationTitle("운동 설정")
                .foregroundColor(Color.white)
                .navigationBarItems(leading: btnBack)
                
                
            }
        }.navigationBarBackButtonHidden()
        
    }
}



