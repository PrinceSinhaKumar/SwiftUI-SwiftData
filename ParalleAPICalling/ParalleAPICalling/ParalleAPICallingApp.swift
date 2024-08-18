//
//  ParalleAPICallingApp.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import SwiftUI
@main
struct ParalleAPICallingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Videos.self, Photos.self])
        }
    }
}
