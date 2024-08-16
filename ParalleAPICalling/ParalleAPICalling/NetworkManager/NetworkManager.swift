//
//  NetworkManager.swift
//  ParalleAPICalling
//
//  Created by  Prince Shrivastav on 16/08/24.
//

import Foundation

final class NetworkManager {
    
    static let instance = NetworkManager()
    private init() {}
    
    func fetchAPIRequest<D: Decodable>( type: D.Type,
                                        from url: URL,
                                        httpMethod: HTTPMethod,
                                        body: Encodable? = nil) async throws -> D {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let postData = body {
            request.httpBody = try JSONEncoder().encode(postData)
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                throw ErrorHandler.InvaildeResponse
            }
            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase
            let jsonData = try decorder.decode(D.self, from: data)
            return jsonData
        } catch let error {
            throw ErrorHandler.serverError(error)
        }
    }
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum ErrorHandler: Error {
    case BadURLError
    case InvaildeResponse
    case serverError(Error)

}
extension ErrorHandler {
    var errorMessage: String {
        switch self {
        case .BadURLError:
            return "!!Bad api request!!"
        case .InvaildeResponse:
            return "||Invalid response||"
        case .serverError(let error):
            return error.localizedDescription
        }
        
    }
}

enum URLs {
    case video
    case photo
    
    var getURL: URL? {
        switch self {
        case .video:
            return URL(string: "https://pixabay.com/api/videos/?key=45461268-35f3ed1138bd4c77430d08dc2&q=yellow+flowers&pretty=true")
        case .photo:
            return URL(string: "https://pixabay.com/api/?key=45461268-35f3ed1138bd4c77430d08dc2&q=yellow+flowers&image_type=photo&pretty=true")
        }
    }
}
