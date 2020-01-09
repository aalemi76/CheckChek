//
//  DataModel.swift
//  CheckCheck
//
//  Created by Catalina on 1/9/20.
//  Copyright © 2020 didAR Tech. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    init() {
        loadChecklists()
    }
    //MARK:- Data Persistancy
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("CheckCheck.plist")
    }
    
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: .atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }
    
    func loadChecklists(){
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path){
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
            } catch{
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }
}
