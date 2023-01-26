//
//  MandoView.swift
//  MoveYourBody
//
//  Created by 권승용 on 2023/01/12.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject{
    let container: NSPersistentContainer
    @Published var savedEntities: [WorkoutEntity]=[]
    init(){
        container = NSPersistentContainer(name: "WorkoutContainer")
        container.loadPersistentStores { (description,error) in
            if let error = error{
                print("ERROR LOADING CORE DATA. \(error)")
            }else{
                print("Successfully loaded core data")
            }
        }
        fetchWorkout()
    }
    
    func fetchWorkout(){
        let request = NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
        do{
            savedEntities = try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching. \(error)")
        }
    }
    
    func addWorkout(text: String){
        let newWorkout = WorkoutEntity(context: container.viewContext)
        newWorkout.type = text
        saveData()
    }
    
    func saveData(){
        do{
            try container.viewContext.save()
            fetchWorkout()
        }catch let error{
            print("Error saving. \(error)")
        }
    }
}

struct WorkoutSettingsView: View {
    @State private var buttonBackColor: Color = Color("neongreen")
    
    @StateObject var vm = CoreDataViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var btnBack: some View{
        Button(action:{self.presentationMode.wrappedValue.dismiss()}){
            HStack{
                Image("go-back")
            }
        }
    }
    var body: some View {
        NavigationView{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                VStack(spacing:30){
                    Text("1회에 몇 분 운동하고 싶으세요?")
                        .font(.headline)
                        .foregroundColor(Color.white)
                    HStack(spacing:20){
                        optionFirstButton()
                        optionSecondButton()
                    }
                    Text("하고 싶지 않은 동작이 있나요?")
                        .font(.headline)
                        .foregroundColor(Color.white)
                    HStack(spacing:20){
                        mnFirstButton()
                        mnSecondButton()
                        mnThirdButton()
                    }
                    HStack(spacing:20){
                        mnFourthButton()
                        mnFifthButton()
                    }
                }
                
                
            }.navigationBarTitle("운동설정")
                .navigationBarItems(leading:
                                        btnBack, trailing: saveButton())
                .onAppear {
                    UINavigationBarAppearance()
                        .setColor(title: .white, background: .black)
                }
            
        }.navigationBarBackButtonHidden(true)}
}

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

