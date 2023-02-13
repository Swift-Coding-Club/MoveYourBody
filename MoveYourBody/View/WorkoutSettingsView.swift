//
//  MandoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/12.
//

import SwiftUI
import Foundation


struct WorkoutSettingsView: View {
    @AppStorage("toggle1") var didTap1: Bool = DefaultSettings.didTap1
    @AppStorage("toggle2") var didTap2: Bool = false
    @AppStorage("toggle3") var didTap3: Bool = false
    @AppStorage("toggle4") var didTap4: Bool = false
    @AppStorage("toggle5") var didTap5: Bool = false
    
    @AppStorage("toggle6") var didTap6: Bool = false
    @AppStorage("toggle7") var didTap7: Bool = false
    
//  let squat = Foundation.UserDefaults.standard.bool(forKey: "isClicked")
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack: some View{
        Button(action:{self.presentationMode.wrappedValue.dismiss()}){
            HStack{
                Image("go-back")
            }.navigationBarBackButtonHidden(true)
        }
    }
    var squat = Foundation.UserDefaults.standard.bool(forKey: "isClicked")
    var body: some View{
        NavigationView{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                VStack (spacing:80){
                    VStack(spacing: 20){
                        Text("하고 싶지 않은 동작이 있나요?")
                        HStack{
                            Button(action:{
                                self.didTap1.toggle()
                            }){
                                Text("스쿼트")
                                    .padding()
                            }
                            .background(didTap1 ? Color.red : Color.green)
                            .cornerRadius(18)
                            
                            Button(action:{
                                self.didTap2.toggle()
                            }){
                                Text("플랭크")
                                    .padding()
                            }
                            .background(didTap2 ? Color.red : Color.green)
                            .cornerRadius(18)
                            
                            Button(action:{
                                self.didTap3.toggle()
                            }){
                                Text("런지")
                                    .padding()
                            }
                            .background(didTap3 ? Color.red : Color.green)
                            .cornerRadius(18)
                            
                        }
                        HStack{
                            Button(action:{
                                self.didTap4.toggle()
                            }){
                                Text("허리 굽히기")
                                    .padding()
                            }
                            .background(didTap4 ? Color.red : Color.green)
                            .cornerRadius(18)
                            
                            Button(action:{
                                self.didTap5.toggle()
                            }){
                                Text("무릎 굽히기")
                                    .padding()
                            }
                            .background(didTap5 ? Color.red : Color.green)
                            .cornerRadius(18)
                        }
                    }
                    
                    VStack{
                        Text("1회 운동 시간은 얼만큼이 좋은가요?")
                        HStack{
                            Button(action:{
                                self.didTap6.toggle()
                            }){
                                Text("3분 이하")
                                    .padding()
                            }
                            .background(didTap6 ? Color.red : Color.green)
                            .cornerRadius(18)
                            
                            Button(action:{
                                self.didTap7.toggle()
                            }){
                                Text("5분 이하")
                                    .padding()
                            }
                            .background(didTap7 ? Color.red : Color.green)
                            .cornerRadius(18)
                        }
                        
                    }
                    
                }
                .foregroundColor(Color.white)
                                .navigationBarItems(leading: btnBack)
                                
            }
        }.navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Title")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
        
    }
}
    


@ViewBuilder
func saveButton() -> some View {
    Button {
        
    } label: {
        Text("Save")
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .multilineTextAlignment(.center)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)       .stroke(OutlineButtonStyle.neongreen, lineWidth: 3))
        
    }
}




struct OutlineButtonStyle: ButtonStyle{
    static let neongreen=Color("neon-green")
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(OutlineButtonStyle.neongreen, lineWidth: 3)
            )
        
            
    }
}

extension UINavigationBarAppearance {
    func setColor(title: UIColor? = nil, background: UIColor? = nil) {
        configureWithTransparentBackground()
        if let titleColor = title {
            largeTitleTextAttributes = [.foregroundColor: titleColor]
            titleTextAttributes = [.foregroundColor: titleColor]
        }
        backgroundColor = background
        UINavigationBar.appearance().scrollEdgeAppearance = self
        UINavigationBar.appearance().standardAppearance = self
    }
}

struct MandoView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSettingsView()
    }
}

