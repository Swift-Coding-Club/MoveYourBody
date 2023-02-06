//
//  Model.swift
//  Favorites
//
//  Created by 안윤진 on 2023/02/04.
//

import Foundation
struct Item: Identifiable,Codable{
    var id: Int
    var title: String
    var isChecked: Bool
    
    static var sampleItems:[Item]{
        var tempList = [Item]()
        
        for i in 1...10{
            let id = i
            let title = "Title \(i)"
            tempList.append(Item(id:id,title:title,isChecked: false))
        }
        return tempList
    }
}

