//
//  TodoItemModel.swift
//  DailyTodos
//
//  Created by Priyanka Mathur on 05/05/24.
//

import Foundation
import SwiftData

@Model
final class CategoryItemModel {
    @Attribute(.unique)
    var title: String
    var type: String? = ""
    var todos: [TodoItemModel]?
    init(title: String = "") {
        self.title = title
    }
}
extension CategoryItemModel {
    static var defaultItem: [CategoryItemModel] {
        let items = [
            CategoryItemModel(title: "Study"),
            CategoryItemModel(title: "Workout")
        ]
        return items
    }
}

@Model
final class TodoItemModel {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompleted: Bool

    @Relationship(deleteRule: .nullify, inverse: (\CategoryItemModel.todos))
    var category: CategoryItemModel?
    
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
