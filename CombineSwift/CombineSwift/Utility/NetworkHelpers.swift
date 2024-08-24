//
//  NetworkHelpers.swift
//  CombineSwift
//
//  Created by  Prince Shrivastav on 22/08/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(String)
    case decodingFailed
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUL"
    case delete = "DELETE"
}

protocol EndPoint {
    var path: String { get }
    var method: HttpMethod { get }
}

enum HomeEndPoint: EndPoint {
    case photoList
    case productList
    case album
    case product(id: String)
    
    
    var path: String {
        switch self {
        case .photoList:
            "https://pixabay.com/api/?key=45461268-35f3ed1138bd4c77430d08dc2&q=yellow+flowers&image_type=photo&pretty=true"
        case .productList:
            "https://api.restful-api.dev/objects"
        case .product(let id):
            "https://api.restful-api.dev/objects/\(id)"
        case .album:
            "https://jsonplaceholder.typicode.com/photos"
        }
    }
    var method: HttpMethod {
        switch self {
        case .photoList, .album, .product, .productList:
                .get
        }
    }
}

enum Progress {
    case start
    case stop
}
