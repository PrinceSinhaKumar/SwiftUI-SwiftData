//
//  ContentView.swift
//  FunWithCodableProtocol
//
//  Created by  Prince Shrivastav on 10/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ListViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: {
            Task {
                try await viewModel.fetchListData()
            }
        })
    }
}

#Preview {
    ContentView()
}
