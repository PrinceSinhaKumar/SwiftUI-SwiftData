//
//  ContentView.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = EntertenmentViewModel(model: FactoryModelImp())
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
                do {
                    async let videos: () = viewModel.fetchList(modelListType: .video(url: .video))
                    async let photos: () = viewModel.fetchList(modelListType: .list(url: .photo))
                    try await [videos, photos]
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        })
    }
}

#Preview {
    ContentView()
}
