//
//  PhotosList.swift
//  CombineSwift
//
//  Created by  Prince Shrivastav on 22/08/24.
//

import Foundation

struct PhotoList: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [Photos]
    
    private enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalHits = "totalHits"
        case hits = "hits"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        total = try values.decode(Int.self, forKey: .total)
        totalHits = try values.decode(Int.self, forKey: .totalHits)
        hits = try values.decode([Photos].self, forKey: .hits)
    }
}
struct Photos: Decodable {
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
    
    init(from decoder: Decoder) throws {
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

struct Product: Decodable {
    let id: String
    let name: String
}

struct Album: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
