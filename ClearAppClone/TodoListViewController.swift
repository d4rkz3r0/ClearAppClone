//
//  ViewController.swift
//  ClearAppClone
//
//  Created by Steve Kerney on 5/13/20.
//  Copyright © 2020 Steve Kerney. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var items = ["Hello", "where's", "my", "tasks?"]
    let kTodoCellReuseIdentifier = "ToDoItemCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func newTaskButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Task", style: .default) { [weak self] action in
            guard let self = self, let newTaskName = alert.textFields?[0].text, !newTaskName.isEmpty else {
                return
            }
            self.items.append(newTaskName)
            self.tableView.reloadData()
        }
        alert.addTextField { textField in
            textField.placeholder = "Task Name Here"
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }

}

extension TodoListViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTodoCellReuseIdentifier, for: indexPath)
        cell.textLabel!.text = items[indexPath.row]
        cell.accessoryType = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        selectedCell.accessoryType = selectedCell.accessoryType == .checkmark ? .none : .checkmark

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

