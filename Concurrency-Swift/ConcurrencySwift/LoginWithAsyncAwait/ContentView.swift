//
//  ContentView.swift
//  ConcurrencySwift
//
//  Created by Priyanka Mathur on 03/08/24.
//

import SwiftUI

struct ContentView: View {
  let viewModel = LoginViewModel(model: LoginModel())
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
      Button("Login") {
          Task {
             try await viewModel.fetchLoginService()
          }
        
      }
    }
    .padding()
  }
}

#Preview {
    ContentView()
}
