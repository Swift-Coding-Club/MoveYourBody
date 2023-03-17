//
//  SYView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/12.
//

import SwiftUI

struct MainView: View {
    @AppStorage("firstVisit") var isFirstTimeVisited: Bool = false
    
    var currentPage: Int = Walkthrough.currentPage
    var body: some View {
            ZStack{
                if isFirstTimeVisited == true {
                    MainScreen()
                } else {
                    OnBoardingView()
                   
                }
        }
    }
}
struct MainScreen: View{
    var body: some View{
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                    .frame(height: 100)
                mainTitle()
                VStack(spacing: 80) {
                    Spacer()
                    
                    startButton()
                    
                    HStack {
                        acheivementsButton()
                            .padding()
                        Spacer()
                        settingsButton()
                            .padding()
                    }
                    
                }
            }
                
            }
        }
    }
    
    @ViewBuilder
    func mainTitle() -> some View {
        VStack {
            Text("MOVE")
                .font(.system(size: 45, weight: .heavy))
                .offset(x: -20)
            Text("YOUR")
                .font(.system(size: 35, weight: .bold))
                .offset(x: 25)
            Text("BODY!!")
                .font(.italic(.system(size: 65, weight: .heavy))())
                .offset(x: 20)
        }
        .foregroundColor(Color("titleForeground"))
    }
    
    @ViewBuilder
    func startButton() -> some View {
        NavigationLink(destination: WorkoutView()){
            Text("START")
                .font(.system(size: 40, weight: .bold))
                .padding()
                .frame(width: 200, height: 200)
                .foregroundColor(.black)
                .background(LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(Circle())
        }.navigationBarHidden(true)
            .padding()
    }
    
    @ViewBuilder
    func settingsButton() -> some View {
        
        NavigationLink(destination: AlarmSettingsView()){
            Image(systemName: "gearshape.fill")
                .font(.system(size: 44, weight: .light))
                .foregroundColor(Color("symbolForeground"))
        }.navigationBarHidden(true)
            .padding()
    }
    
    
    @ViewBuilder
    func acheivementsButton() -> some View {
        NavigationLink(destination: WorkoutSettingsView()){
            
            Image(systemName: "figure.run")
                .font(.system(size: 44, weight: .regular))
                .foregroundColor(Color("symbolForeground"))
        }
        .navigationBarHidden(true)
        .padding()
    }
struct SYView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
