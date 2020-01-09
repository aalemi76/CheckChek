//
//  Checklist.swift
//  CheckCheck
//
//  Created by Catalina on 1/5/20.
//  Copyright © 2020 didAR Tech. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    init(name: String) {
        self.name = name
        super.init()
    }
}
