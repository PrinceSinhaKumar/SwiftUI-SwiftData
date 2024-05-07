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
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    var body: some Scene {
        WindowGroup {
            TodosListView()
        }
        .modelContainer(SwiftDataContainer.create(isFirstLaunch: &isFirstLaunch))
    }
}
