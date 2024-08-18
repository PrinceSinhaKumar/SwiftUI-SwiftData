//
//  SwiftDataModel.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import Foundation
import SwiftData

//MARK: - Video Model
class VideoList: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [Videos]
    
    private enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalHits = "totalHits"
        case hits = "hits"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decode(Int.self, forKey: .total)
        totalHits = try values.decode(Int.self, forKey: .totalHits)
        hits = try values.decode([Videos].self, forKey: .hits)
    }
}

@Model
class Videos: Decodable {
    @Attribute(.unique)
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
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case pageURL = "pageURL"
        case type = "type"
        case tags = "tags"
        case duration = "duration"
        case videos = "videos"
        case views = "views"
        case downloads = "downloads"
        case likes = "likes"
        case comments = "comments"
        case userId = "user_id"
        case user = "user"
        case userImageURL = "userImageURL"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        pageURL = try values.decode(String.self, forKey: .pageURL)
        type = try values.decode(String.self, forKey: .type)
        tags = try values.decode(String.self, forKey: .tags)
        duration = try values.decode(Int.self, forKey: .duration)
        videos = try values.decode(VideoType.self, forKey: .videos)
        views = try values.decode(Int.self, forKey: .views)
        downloads = try values.decode(Int.self, forKey: .downloads)
        likes = try values.decode(Int.self, forKey: .likes)
        comments = try values.decode(Int.self, forKey: .comments)
        userId = try values.decode(Int.self, forKey: .userId)
        user = try values.decode(String.self, forKey: .user)
        userImageURL = try values.decode(String.self, forKey: .userImageURL)
    }
}

@Model
class VideoType: Decodable {
    let large: VideoData
    let medium: VideoData
    let small: VideoData
    let tiny: VideoData
    
    private enum CodingKeys: String, CodingKey {
        case large = "large"
        case medium = "medium"
        case small = "small"
        case tiny = "tiny"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        large = try values.decode(VideoData.self, forKey: .large)
        medium = try values.decode(VideoData.self, forKey: .medium)
        small = try values.decode(VideoData.self, forKey: .small)
        tiny = try values.decode(VideoData.self, forKey: .tiny)
    }
}

@Model
class VideoData: Decodable {
    let url: String
    let width:Int
    let height:Int
    let size:Int
    let thumbnail: String
    
    private enum CodingKeys: String, CodingKey {
        case url = "url"
        case width = "width"
        case height = "height"
        case size = "size"
        case thumbnail = "thumbnail"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decode(String.self, forKey: .url)
        width = try values.decode(Int.self, forKey: .width)
        height = try values.decode(Int.self, forKey: .height)
        size = try values.decode(Int.self, forKey: .size)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
    }
}

//MARK: - Photo Model
class PhotoList: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [Photos]
    
    private enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalHits = "totalHits"
        case hits = "hits"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decode(Int.self, forKey: .total)
        totalHits = try values.decode(Int.self, forKey: .totalHits)
        hits = try values.decode([Photos].self, forKey: .hits)
    }
}

@Model
class Photos: Decodable {
    @Attribute(.unique)
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
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case pageURL = "pageURL"
        case type = "type"
        case tags = "tags"
        case previewURL = "previewURL"
        case previewWidth = "previewWidth"
        case previewHeight = "previewHeight"
        case webformatURL = "webformatURL"
        case webformatWidth = "webformatWidth"
        case webformatHeight = "webformatHeight"
        case largeImageURL = "largeImageURL"
        case imageWidth = "imageWidth"
        case imageHeight = "imageHeight"
        case imageSize = "imageSize"
        case views = "views"
        case downloads = "downloads"
        case collections = "collections"
        case likes = "likes"
        case comments = "comments"
        case userId = "user_id"
        case user = "user"
        case userImageURL = "userImageURL"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        pageURL = try values.decode(String.self, forKey: .pageURL)
        type = try values.decode(String.self, forKey: .type)
        tags = try values.decode(String.self, forKey: .tags)
        previewURL = try values.decode(String.self, forKey: .previewURL)
        previewWidth = try values.decode(Int.self, forKey: .previewWidth)
        previewHeight = try values.decode(Int.self, forKey: .previewHeight)
        webformatURL = try values.decode(String.self, forKey: .webformatURL)
        webformatWidth = try values.decode(Int.self, forKey: .webformatWidth)
        webformatHeight = try values.decode(Int.self, forKey: .webformatHeight)
        largeImageURL = try values.decode(String.self, forKey: .largeImageURL)
        imageWidth = try values.decode(Int.self, forKey: .imageWidth)
        imageHeight = try values.decode(Int.self, forKey: .imageHeight)
        imageSize = try values.decode(Int.self, forKey: .imageSize)
        views = try values.decode(Int.self, forKey: .views)
        downloads = try values.decode(Int.self, forKey: .downloads)
        collections = try values.decode(Int.self, forKey: .collections)
        likes = try values.decode(Int.self, forKey: .likes)
        comments = try values.decode(Int.self, forKey: .comments)
        userId = try values.decode(Int.self, forKey: .userId)
        user = try values.decode(String.self, forKey: .user)
        userImageURL = try values.decode(String.self, forKey: .userImageURL)
    }
}
