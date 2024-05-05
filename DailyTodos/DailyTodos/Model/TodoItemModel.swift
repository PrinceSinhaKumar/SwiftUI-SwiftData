//
//  TodoItemModel.swift
//  DailyTodos
//
//  Created by Priyanka Mathur on 05/05/24.
//

import Foundation
import SwiftData

@Model
final class TodoItemModel {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompleted: Bool

    init(title: String = "",
         timestamp: Date = .now,
         isCritical: Bool = false,
         isCompleted: Bool = false) {
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isCompleted = isCompleted
    }
}
