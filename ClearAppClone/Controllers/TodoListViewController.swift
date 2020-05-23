//
//  ViewController.swift
//  ClearAppClone
//
//  Created by Steve Kerney on 5/13/20.
//  Copyright © 2020 Steve Kerney. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var tasks: [Task] = []
    let kTodoCellReuseIdentifier = "ToDoItemCell"
    let kTaskArrayUserDefaultKey = "ToDoListArray"
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        tasks.append(Task(title: "Where"))
        tasks.append(Task(title: "are"))
        tasks.append(Task(title: "my", isDone: true))
        tasks.append(Task(title: "tasks?", isDone: true))
        tasks.append(Task(title: "1"))
        tasks.append(Task(title: "2"))
        tasks.append(Task(title: "3"))
        tasks.append(Task(title: "4"))
        tasks.append(Task(title: "5"))
        tasks.append(Task(title: "6"))
        tasks.append(Task(title: "7"))
        tasks.append(Task(title: "8"))
        tasks.append(Task(title: "9"))
        tasks.append(Task(title: "10"))
        tasks.append(Task(title: "11"))
        tasks.append(Task(title: "12"))
        tasks.append(Task(title: "13"))
        tasks.append(Task(title: "14"))
        tasks.append(Task(title: "15"))
        

        // Retrieve saved tasks, if any
        if let savedTasks = defaults.array(forKey: kTaskArrayUserDefaultKey) as? [Task] {
            tasks = savedTasks
        }
    }

    @IBAction func newTaskButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Task", style: .default) { [weak self] action in
            guard let self = self, let newTaskName = alert.textFields?[0].text, !newTaskName.isEmpty else {
                return
            }
            self.tasks.append(Task(title: newTaskName))

            // Save tasks to UserDefaults
            self.defaults.set(self.tasks, forKey: self.kTaskArrayUserDefaultKey)

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        // Update Model
        tasks[indexPath.row].isDone = !tasks[indexPath.row].isDone

        // Update View
        selectedCell.accessoryType = tasks[indexPath.row].isDone ? .checkmark : .none
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTodoCellReuseIdentifier, for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel!.text = task.title
        cell.accessoryType = task.isDone ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
}
