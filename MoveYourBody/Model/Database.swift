//
//  Database.swift
//  Favorites
//
//  Created by 안윤진 on 2023/02/04.
//

import Foundation
final class Database{
    
    private let CHECK_KEY = "check_key"
    
    func save(items: Set<Int>){
        let array = Array(items)
        UserDefaults.standard.set(array,forKey: CHECK_KEY)
    }
    
    func load() -> Set<Int>{
        let array = UserDefaults.standard.array(forKey: CHECK_KEY) as? [Int] ?? [Int]()
        return Set(array)
    }
}
