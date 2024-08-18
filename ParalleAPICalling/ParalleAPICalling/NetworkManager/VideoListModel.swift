//
//  VideoListModel.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import Foundation

protocol ListModel {
    associatedtype type
    var url: URLs { get set }
    func fetchListService() async throws -> type
}

class VideoListModel: ListModel {
    var url: URLs
    init(url: URLs) {
        self.url = url
    }
    func fetchListService() async throws -> VideoList {
        guard let url = url.getURL else {
            throw ErrorHandler.BadURLError
        }
        do {
           return try await NetworkManager.instance.fetchAPIRequest(type: VideoList.self, from: url, httpMethod: .GET)
        } catch let error {
            throw error
        }
    }
}

