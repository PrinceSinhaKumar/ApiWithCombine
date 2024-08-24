//
//  NetworkManager.swift
//  CombineSwift
//
//  Created by  Prince Shrivastav on 22/08/24.
//

import Foundation
import Combine

protocol NetworkService {
    func request<T: Decodable>(_ endPoint: EndPoint, type: T.Type, parameters: Encodable?) -> AnyPublisher<T, APIError>
}

class NetworkManager: NetworkService {
    
    func request<T: Decodable>(_ endPoint: EndPoint, type: T.Type, parameters: Encodable? = nil) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: endPoint.path) else { return Fail(error: APIError.invalidURL).eraseToAnyPublisher() }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        if let parameters {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let postData = try JSONEncoder().encode(parameters)
                urlRequest.httpBody = postData
            } catch  {
                return Fail(error: APIError.requestFailed("Encoding parameters failed.")).eraseToAnyPublisher()
            }
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw APIError.requestFailed("Request failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? .zero)")
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .mapError({ error -> APIError in
                if error is DecodingError {
                    return APIError.decodingFailed
                } else if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError.requestFailed("An unknown error occurred.")
                }
            })
            .eraseToAnyPublisher()
    }
    
}
