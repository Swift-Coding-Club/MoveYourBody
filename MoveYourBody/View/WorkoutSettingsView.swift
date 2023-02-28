//
//  MandoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/12.


import SwiftUI


struct WorkoutSettingsView: View {
    @AppStorage("firstVisit") var isFirstTimeVisited = true
    //Onboarding Screen을 띄우기 위한 변수
    
    //각 설정 버튼에 대한 클릭 여부 저장, Mainview의 enum DefaultSettings로 여러 뷰에서 변수를 이용할 수 있게 하였음.

    @AppStorage("toggle1") var didTap1: Bool = WorkoutSettings.didTap1
    @AppStorage("toggle2") var didTap2: Bool = WorkoutSettings.didTap2
    @AppStorage("toggle3") var didTap3: Bool = WorkoutSettings.didTap3
    @AppStorage("toggle4") var didTap4: Bool = WorkoutSettings.didTap4
    @AppStorage("toggle5") var didTap5: Bool = WorkoutSettings.didTap5

    @AppStorage("toggle6") var didTap6: Bool = WorkoutSettings.didTap6
    @AppStorage("toggle7") var didTap7: Bool = WorkoutSettings.didTap7

    //btnBack을 눌렀을 때 메인화면으로 돌아가기 위함.
    //ios15에서 presentationMode는 deprecated됨
    @Environment(\.dismiss) private var dismiss

    //정의하였으나 사용법을 모름
    let gradient2 = LinearGradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")], startPoint: .topLeading, endPoint: .bottomTrailing)

    //메인 화면으로 돌아가는 버튼, 네비게이션이 아닌 현재 화면을 지워서 돌아감
    @State private var buttonBackColor: Color = Color("neongreen")
    
    @StateObject var vm = ViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnBack: some View{
        Button(action:{dismiss()}){
            HStack{
                Image("go-back")
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


                                Button{
                                    self.didTap1.toggle()

                                }label:{
                                    Text("스쿼트")
                                        .foregroundColor(didTap1 ? .black: .white)
                                        .padding()
                                        .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                                )

                                }//그래디언트 버튼 클릭 설정 backgroundColor(didTap1? LinearGradient~: Color("background")) > 타입 불일치 에러 ----> Color("background")를 사용할 때에도 gradient를 적용한 후 gradient에 didTap1 적용 > 다시 background 적용으로 해결
                                .background(LinearGradient(gradient: didTap1 ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)





                            Button(action:{
                                self.didTap2.toggle()
                            }){
                                Text("플랭크")
                                    .foregroundColor(didTap2 ? .black: .white)
                                    .padding()
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                            )
                            }
                            .background(LinearGradient(gradient: didTap2 ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)


                            Button(action:{
                                self.didTap3.toggle()
                            }){
                                Text("런지")
                                    .foregroundColor(didTap3 ? .black: .white)
                                    .padding()
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                            )
                            }
                            .background(LinearGradient(gradient: didTap3 ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)


                        }
                        HStack{
                            Button(action:{
                                self.didTap4.toggle()
                            }){
                                Text("상체")
                                    .foregroundColor(didTap4 ? .black: .white)
                                    .padding()
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                            )
                            }
                            .background(LinearGradient(gradient: didTap4 ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)

                            Button(action:{
                                self.didTap5.toggle()
                            }){
                                Text("하체")
                                    .foregroundColor(didTap5 ? .black: .white)
                                    .padding()
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                            )
                            }
                            .background(LinearGradient(gradient: didTap5 ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)                        }
                    }

                    VStack( spacing: 20){
                        Text("1회 운동 시간은 얼만큼이 좋은가요?")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)

                        HStack{
                            Button(action:{
                                self.didTap6.toggle()
                            }){
                                Text("3분 이하")
                                    .foregroundColor(didTap6 ? .black: .white)
                                    .padding()
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                            )
                            }
                            .background(LinearGradient(gradient: didTap6 ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)

                            Button(action:{
                                self.didTap7.toggle()
                            }){
                                Text("5분 이하")
                                    .foregroundColor(didTap7 ? .black: .white)
                                    .padding()
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color("buttonBackgroundStart"),lineWidth: 3)
                                            )
                            }
                            .background(LinearGradient(gradient: didTap7 ? Gradient(colors: [Color("buttonBackgroundStart"), Color("buttonBackgroundEnd")]) : Gradient(colors: [Color("background")]), startPoint: .leading, endPoint: .trailing))
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
////별도의 Save 버튼 없이 설정 사항이 저장됨.
//    var body: some View {
//        ZStack{
//            Color("background")
//                .ignoresSafeArea()
//            VStack {
//                ForEach(vm.filteredItems){
//                    item in HStack{
//                        Button(action:{
//                            vm.toggleCheck(item: item)
//                        }){
//                            Text(item.title)
//                                .font(.headline)
//                        }
//                        .foregroundColor(Color.black)
//                        .font(.system(size:14).bold())
//                        .padding(15)
//                        .background(vm.contains(item) ? Color.green: Color.red)
//                        
//                    }
//                }
//            }
//            
//            
//        }.navigationBarTitle("운동설정")
//            .navigationBarItems(leading:
//                                    btnBack, trailing: saveButton())
//        
//        
//        .navigationBarBackButtonHidden(true)}
//}

@ViewBuilder
func saveButton() -> some View {
    Button {
        
    } label: {
        Text("Save")
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)       .stroke(OutlineButtonSytle.neongreen, lineWidth: 3))
        
    }
}

@ViewBuilder
func optionFirstButton() -> some View {
    Button {
        
    } label: {
        Text("3분이하")
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)       .stroke(OutlineButtonSytle.neongreen, lineWidth: 3))
        
    }
}

@ViewBuilder
func mnFirstButton() -> some View {
    Button {
        
    } label: {
        Text("스쿼트")
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)       .stroke(OutlineButtonSytle.neongreen, lineWidth: 3))
        
    }
}

@ViewBuilder
func mnSecondButton() -> some View {
    Button {
        
    } label: {
        Text("플랭크")
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)       .stroke(OutlineButtonSytle.neongreen, lineWidth: 3))
        
    }
}

@ViewBuilder
func mnThirdButton() -> some View {
    Button {
        
    } label: {
        Text("런지")
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)       .stroke(OutlineButtonSytle.neongreen, lineWidth: 3))
        
    }
}

@ViewBuilder
func mnFourthButton() -> some View {
    Button {
        
    } label: {
        Text("허리 굽히기")
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)       .stroke(OutlineButtonSytle.neongreen, lineWidth: 3))
        
    }
}

@ViewBuilder
func mnFifthButton() -> some View {
    Button {
        
    } label: {
        Text("무릎 굽히기")
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)       .stroke(OutlineButtonSytle.neongreen, lineWidth: 3))
        
    }
}

@ViewBuilder
func optionSecondButton() -> some View {
    Button {
        
    } label: {
        Text("5분이하")
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)       .stroke(OutlineButtonSytle.neongreen, lineWidth: 3))
        
    }
}

struct OutlineButtonSytle: ButtonStyle{
    static let neongreen=Color("neon-green")
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .font(.system(size:14).bold())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(OutlineButtonSytle.neongreen, lineWidth: 3)
            )
    }
}
