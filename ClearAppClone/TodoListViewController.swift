//
//  ViewController.swift
//  ClearAppClone
//
//  Created by Steve Kerney on 5/13/20.
//  Copyright © 2020 Steve Kerney. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let items = ["Hello", "where's", "my", "tasks?"]
    let kTodoCellReuseIdentifier = "ToDoItemCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TodoListViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTodoCellReuseIdentifier, for: indexPath)
        cell.textLabel!.text = items[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

