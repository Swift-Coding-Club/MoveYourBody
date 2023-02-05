//
//  ContentViewModel.swift
//  Favorites
//
//  Created by 안윤진 on 2023/02/04.
//

import Foundation
extension WorkoutSettingsView {
    
    final class ViewModel: ObservableObject{
        @Published var items = [Item]()
        @Published var showingChecked = false //
        @Published var savedItems: Set<Int> = [1,7]//디폴트 체크
        @Published var tempList = [Item]()
        private var db = Database()
        
        init(){
            self.savedItems = db.load()
            self.items = Item.sampleItems
        }
        
        
        var filteredItems:[Item]{
            if showingChecked{
                return items.filter{savedItems.contains($0.id)}
            }else{
                return items
            }
        }
        
        func contains(_ item:Item) -> Bool{
            savedItems.contains(item.id)
        }//체크한 버튼 저장
        
        func toggleCheck(item:Item){
            if contains(item){
                savedItems.remove(item.id)
            }else{
                savedItems.insert(item.id)
            }
            db.save(items: savedItems)
        }
    }
    
}
