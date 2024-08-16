//
//  VideoListModel.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import Foundation

struct VideoList: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [Videos]
}

struct Videos: Decodable, Identifiable {
    let id: Int
    let pageURL: String
    let type: String
    let tags: String
    let duration: Int
    let videos: VideoType
    let views: Int
    let downloads: Int
    let likes: Int
    let comments: Int
    let userId: Int
    let user: String
    let userImageURL: String
}

struct VideoType: Decodable {
    let large: VideoData
    let medium: VideoData
    let small: VideoData
    let tiny: VideoData
}

struct VideoData: Decodable {
    let url: String
    let width:Int
    let height:Int
    let size:Int
    let thumbnail: String
}

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

