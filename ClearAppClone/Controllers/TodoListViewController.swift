//
//  ViewController.swift
//  ClearAppClone
//
//  Created by Steve Kerney on 5/13/20.
//  Copyright © 2020 Steve Kerney. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var tasks: [Task] = []
    let kTodoCellReuseIdentifier = "ToDoItemCell"
    // UserDefaults
    let kTaskArrayUserDefaultKey = "ToDoListArray"
    // NSCoder
    var kUserTasksPListFilePath: URL? = nil
    let kTaskPListFileName = "Tasks.plist"
    // CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load Tasks
        loadTasksFromCoreData()
    }

    @IBAction func newTaskButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Task", style: .default) { [weak self] action in
            guard let self = self, let newTaskName = alert.textFields?[0].text, !newTaskName.isEmpty else {
                return
            }

            // Save Task
            let newTask = self.createCoreDataTaskObject(title: newTaskName)
            self.tasks.append(newTask)
            self.saveTasksToCoreData()

            self.tableView.reloadData()
        }
        alert.addTextField { textField in
            textField.placeholder = "Task Name Here"
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

//MARK: - Task->CoreData Saving/Loading

extension TodoListViewController {

    func createCoreDataTaskObject(title: String, isDone: Bool = false) -> Task {
        let task = Task(context: context)
        task.title = title
        task.isDone = isDone
        return task
    }

    func saveTasksToCoreData() {
        do {
            try context.save()
        } catch { print("Unable to save task data into CoreData: \(error.localizedDescription)") }
    }

    func loadTasksFromCoreData() {
        let taskRequest: NSFetchRequest<Task> = NSFetchRequest(entityName: "Task")
        do {
            tasks = try context.fetch(taskRequest)
        } catch { print("Unable to load task data from CoreData: \(error.localizedDescription)") }
    }
}

//MARK: - Task->PList Saving/Loading

/*
extension TodoListViewController {

    func initializePListFilePath() {
         kUserTasksPListFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(kTaskPListFileName)
    }

    func saveTasksToPList() {
        // Save tasks via NSCoding
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(tasks)
            try data.write(to: kUserTasksPListFilePath!)
        } catch { print("Unable to encode task data into PList file via NSCoding: \(error.localizedDescription)") }
    }

    func loadTasksFromPList() {
        // Retrieve saved tasks, if any
        guard let data = try? Data(contentsOf: kUserTasksPListFilePath!) else {
            print("Warning: Task PList file does not exist, try saving a Task first.")
            return
        }

        let decoder = PropertyListDecoder()
        do {
            tasks = try decoder.decode([Task].self, from: data)
        } catch { print("Unable to decode task data from PList file: \(error.localizedDescription)") }
    }
}
*/

extension TodoListViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        // Update Model
        tasks[indexPath.row].isDone = !tasks[indexPath.row].isDone

        // Save Tasks
        saveTasksToCoreData()

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
