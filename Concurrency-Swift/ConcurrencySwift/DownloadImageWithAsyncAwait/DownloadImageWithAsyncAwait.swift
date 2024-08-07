//
//  DownloadImageWithAsyncAwait.swift
//  ConcurrencySwift
//
//  Created by  Prince Shrivastav on 07/08/24.
//

import SwiftUI

class DownloadImageManager {
    
    func getImage(completionHandler: @escaping (UIImage?, Error?) -> ()) {
        let url = URL(string: "https://picsum.photos/200")!
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let imageData = data,
                  let image = UIImage(data: imageData),
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                return completionHandler(nil, error)
            }
            return completionHandler(image, nil)
        }.resume()
    }
}

class DownloadImageWithAsyncAwaitViewModel: ObservableObject {
    
    @Published var image: UIImage?
    let imageManager = DownloadImageManager()
    
    func fetchImage() {
        imageManager.getImage { [weak self] image, error in
            if let image {
                self?.image = image
            }
            print(error?.localizedDescription ?? "")
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
            viewModel.fetchImage()
        })
    }
}

#Preview {
    DownloadImageWithAsyncAwait()
}
