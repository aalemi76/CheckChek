//
//  ViewController.swift
//  CheckCheck
//
//  Created by Catalina on 12/31/19.
//  Copyright © 2019 didAR Tech. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Mark:- Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        if indexPath.row == 0 {
            label.text = "Learn Python Development"
        } else if indexPath.row == 1 {
            label.text = "Brush my Teeth"
        } else if indexPath.row == 2 {
            label.text = "Learn iOS Development"
        } else if indexPath.row == 3 {
            label.text = "Machine Learning Time!"
        } else if indexPath.row == 4 {
            label.text = "Social Media"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

