//
//  LoginModel.swift
//  ConcurrencySwift
//
//  Created by Priyanka Mathur on 03/08/24.
//

import Foundation

enum OptionalErrorResult<Success> {
    case success(Success)
    case failure(Error?)
}

typealias Handler = OptionalErrorResult<Decodable?>

final class NetworkManager {
  static let sharedInstance = NetworkManager()
  private init() {}
  
  func fetchService<T: Decodable>(type: T.Type,
                                  url: URL,
                                  container: Encodable? = nil,
                                  header: String? = nil,
                                  completion: @escaping (Handler) -> ()) {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    if let container = container as? LoginContainer {
      let parameters = "username=\(container.username)&password=\(container.password)"
      let postData =  parameters.data(using: .utf8)
      request.httpMethod = "POST"
      request.httpBody = postData
    }
    if let header = header {
      request.addValue(header, forHTTPHeaderField: "Authorization")
    }
    let session = URLSession(configuration: .default)
    session.dataTask(with: request) { data, response, error in
      guard error == nil else {
        return completion(.failure(error))
      }
      guard let data = data else {
        return completion(.failure(NSError(domain: "Empty data", code: -0001)))
      }
      do {
        let data = try JSONDecoder().decode(T.self, from: data)
        completion(.success(data))
      } catch let error {
        completion(.failure(error))
      }
    }.resume()
  }
  
  func fetchServiceV2<T: Decodable>(type: T.Type,
                                    url: URL,
                                    container: Encodable? = nil,
                                    header: String? = nil) async throws -> T {
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    if let container = container as? LoginContainer {
      let parameters = "username=\(container.username)&password=\(container.password)"
      let postData =  parameters.data(using: .utf8)
      request.httpMethod = "POST"
      request.httpBody = postData
    }
    if let header = header {
      request.addValue(header, forHTTPHeaderField: "Authorization")
    }
    
    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      guard let httpResCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(httpResCode) else {
        throw NSError(domain: "Error code", code: -0002)
      }
      return try JSONDecoder().decode(T.self, from: data)
    } catch let error {
      throw error
    }
  }
}

class LoginModel {
    
  func fetchLoginData(container: LoginContainer) async throws -> LoginDataModel {
    
    guard let url = URL(string: "https://dummyjson.com/auth/login") else {
      throw NSError(domain: "!!Bad request!!", code: -0000)
    }
    do {
      return try await NetworkManager.sharedInstance.fetchServiceV2(type: LoginDataModel.self, url: url, container: container)
    } catch let error {
      throw error
    }
  }
  
  func fetchUserData(headerToken: String) async throws -> UserDataModel {
    guard let url = URL(string: "https://dummyjson.com/auth/me") else {
      throw NSError(domain: "!!Bad request!!", code: -0000)
    }
    do {
      return try await NetworkManager.sharedInstance.fetchServiceV2(type: UserDataModel.self, url: url, header: headerToken)
    } catch let error {
      throw error
    }
  }
}
