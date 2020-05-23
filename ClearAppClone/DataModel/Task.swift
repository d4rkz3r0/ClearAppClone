//
//  Item.swift
//  ClearAppClone
//
//  Created by Steve Kerney on 5/22/20.
//  Copyright © 2020 Steve Kerney. All rights reserved.
//

import Foundation

class Task {
    var title: String = "Item"
    var isDone: Bool = false

    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
}
