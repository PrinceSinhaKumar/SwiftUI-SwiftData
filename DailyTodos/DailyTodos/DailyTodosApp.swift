//
//  DailyTodosApp.swift
//  DailyTodos
//
//  Created by Priyanka Mathur on 05/05/24.
//

import SwiftUI
import SwiftData
@main
struct DailyTodosApp: App {
    var body: some Scene {
        WindowGroup {
            TodosListView()
                .modelContainer(for: TodoItemModel.self)
        }
    }
}
