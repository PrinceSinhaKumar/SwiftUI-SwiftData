//
//  PhotoListModel.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import Foundation

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
