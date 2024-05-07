//
//  SaveApiImageInSwiftDataApp.swift
//  SaveApiImageInSwiftData
//
//  Created by Priyanka Mathur on 07/05/24.
//

import SwiftUI

@main
struct SaveApiImageInSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ProjectListView()
                .modelContainer(for: [Products.self])

        }
    }
}
