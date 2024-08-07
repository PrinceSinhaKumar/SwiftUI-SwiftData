//
//  ConcurrencySwiftApp.swift
//  ConcurrencySwift
//
//  Created by Priyanka Mathur on 03/08/24.
//

import SwiftUI

@main
struct ConcurrencySwiftApp: App {
    var body: some Scene {
        WindowGroup {
            DownloadImageWithAsyncAwait()
        }
    }
}
