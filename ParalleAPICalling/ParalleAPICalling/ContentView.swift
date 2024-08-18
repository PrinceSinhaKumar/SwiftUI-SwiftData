//
//  ContentView.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query private var videos: [Videos]
    @Query private var photos: [Photos]
    
    @StateObject var viewModel = EntertenmentViewModel(model: FactoryModelImp())

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(videos.first?.videos.large.url.description ?? "")
        }
        .padding()
        .task {
            if videos.isEmpty {
                do {
                    async let videos = viewModel.fetchList(modelListType: .video(url: .video))
                    async let photos = viewModel.fetchList(modelListType: .list(url: .photo))
                    let data = try await [videos, photos]
                    print("API Response \(data)")
                    saveData(data: data)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

private extension ContentView {
    func saveData(data: [Decodable]) {
        if let videos = data.first as? VideoList {
            videos.hits.forEach({context.insert($0)})
        }
        if let photos = data.last as? PhotoList {
            photos.hits.forEach({context.insert($0)})
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Videos.self, Photos.self])
}
