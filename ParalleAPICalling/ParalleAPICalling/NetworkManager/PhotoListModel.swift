//
//  PhotoListModel.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import Foundation

struct PhotoList: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [Photos]
}
struct Photos: Decodable , Identifiable {
    let id: Int
    let pageURL: String
    let type: String
    let tags: String
    let previewURL: String
    let previewWidth: Int
    let previewHeight: Int
    let webformatURL: String
    let webformatWidth: Int
    let webformatHeight: Int
    let largeImageURL: String
    let imageWidth: Int
    let imageHeight: Int
    let imageSize: Int
    let views: Int
    let downloads: Int
    let collections: Int
    let likes: Int
    let comments: Int
    let userId: Int
    let user: String
    let userImageURL: String
}

class PhotoListModel: ListModel {
    var url: URLs
    init(url: URLs) {
        self.url = url
    }
    func fetchListService() async throws -> PhotoList {
        guard let url = url.getURL else {
            throw ErrorHandler.BadURLError
        }
        do {
           return try await NetworkManager.instance.fetchAPIRequest(type: PhotoList.self, from: url, httpMethod: .GET)
        } catch let error {
            throw error
        }
    }
    
}
