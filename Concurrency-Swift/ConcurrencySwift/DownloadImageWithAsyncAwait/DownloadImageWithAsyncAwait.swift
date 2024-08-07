//
//  DownloadImageWithAsyncAwait.swift
//  ConcurrencySwift
//
//  Created by  Prince Shrivastav on 07/08/24.
//

import SwiftUI
import Combine

class DownloadImageManager {
    
    fileprivate func responseHandler(_ data: Data?,
                                     _ response: URLResponse?) -> UIImage? {
        guard let imageData = data,
              let image = UIImage(data: imageData),
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    func getImageWithEscapingClouser(completionHandler: @escaping (UIImage?, Error?) -> ()) {
        let url = URL(string: "https://picsum.photos/200")!
        URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            let image = self?.responseHandler(data,
                                        response)
            return completionHandler(image, nil)
        }.resume()
    }
    
    func getImageWithCombine() -> AnyPublisher<UIImage?, Error> {
        let url = URL(string: "https://picsum.photos/200")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(responseHandler)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func getImageWithAsyncAwait() async throws -> UIImage? {
        guard let url = URL(string: "https://picsum.photos/200") else {
            throw URLError(.badURL)
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return responseHandler(data, response)
        } catch let error {
            throw error
        }
    }
    
}

class DownloadImageWithAsyncAwaitViewModel: ObservableObject {
    
    @Published var image: UIImage?
    let imageManager = DownloadImageManager()
    var cancelable = Set<AnyCancellable>()
    
    func fetchImage() async {
        //using escaping clouser
        /* imageManager.getImageWithEscapingClouser { [weak self] image, error in
         if let image {
         self?.image = image
         }
         print(error?.localizedDescription ?? "")
         } */
        
        //using combine
        /* imageManager.getImageWithCombine()
         .receive(on: DispatchQueue.main)
         .sink { completion in
         switch completion {
         case .failure(let error):
         print(error)
         default:
         break
         }
         } receiveValue: { [weak self] image in
         self?.image = image
         }
         .store(in: &cancelable)
         */
        
        //using async-await'
        let image = try? await imageManager.getImageWithAsyncAwait()
        await MainActor.run {
            self.image = image
        }
        
    }
}

struct DownloadImageWithAsyncAwait: View {
    @StateObject var viewModel = DownloadImageWithAsyncAwaitViewModel()
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear(perform: {
            Task {
                await viewModel.fetchImage()
            }
        })
    }
}

#Preview {
    DownloadImageWithAsyncAwait()
}
