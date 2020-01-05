//
//  ChecklistItem.swift
//  CheckCheck
//
//  Created by Catalina on 1/1/20.
//  Copyright © 2020 didAR Tech. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    
    func toggleChecked(){
        checked = !checked
    }
}
