//
//  AllListsViewController.swift
//  CheckCheck
//
//  Created by Catalina on 1/5/20.
//  Copyright © 2020 didAR Tech. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- Navigation Controller Delegates
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
    
    // was the back button tapped?
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
        }
    }
    
    //MARK:- List Detail View Controller Delegates
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        dataModel.lists.append(checklist)
        dataModel.sortChecklists()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        dataModel.sortChecklists()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- View
    
    let cellIdentifier = "ChecklistCell"
    var dataModel: DataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let c = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
            cell = c
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        cell.textLabel!.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        let count = checklist.countUncheckedItems()
        if checklist.items.count == 0 {
            cell.detailTextLabel!.text = "No Item!"
        } else {
            cell.detailTextLabel!.text = count == 0 ? "All Done!" : "\(count) To Go!"
        }
        cell.detailTextLabel!.font = UIFont(name: "Arial Rounded", size: 10)
        cell.imageView!.image = UIImage(named: checklist.iconName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataModel.indexOfSelectedChecklist = indexPath.row
        let checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Are you sure?", message: "If you delete the list you can no longer have access to it.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler:{ action in
            self.dataModel.lists.remove(at: indexPath.row)
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: {(ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            self.performSegue(withIdentifier: "EditChecklist", sender: tableView.cellForRow(at: indexPath))
            success(true)})
        editAction.backgroundColor = .purple
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        controller.delegate = self
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist"{
            let controller = segue.destination as! ChecklistViewController
            controller.checklist = sender as? Checklist
        } else if segue.identifier == "AddChecklist"{
            let controller =  segue.destination as! ListDetailViewController
            controller.delegate = self
            } else if segue.identifier == "EditChecklist"{
                let controller =  segue.destination as! ListDetailViewController
                controller.delegate = self
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                    controller.checklistToEdit = dataModel.lists[indexPath.row]
            }
        }
    }
}
