//
//  SwiftDataContainer.swift
//  DailyTodos
//
//  Created by Priyanka Mathur on 07/05/24.
//

import Foundation
import SwiftData

actor SwiftDataContainer {
    @MainActor
    static func create(isFirstLaunch: inout Bool) -> ModelContainer {
        let schema = Schema([TodoItemModel.self], version: .init(1, 0, 0))//Schema([TodoItemModel.self])
        let configuration = ModelConfiguration(schema: schema)
        let container = try! ModelContainer(for: schema, configurations: configuration)
        if isFirstLaunch {
            CategoryItemModel.defaultItem.forEach { container.mainContext.insert($0) }
            isFirstLaunch = false
        }
        return container
    }
}
