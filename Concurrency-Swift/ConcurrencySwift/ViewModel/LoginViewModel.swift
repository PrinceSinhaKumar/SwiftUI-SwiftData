//
//  LoginViewModel.swift
//  ConcurrencySwift
//
//  Created by Priyanka Mathur on 04/08/24.
//

import Foundation

class LoginViewModel {
  
  let model: LoginModel
  
  init(model: LoginModel) {
    self.model = model
  }
  
    func fetchLoginService() async throws {
        
        do {
           let loginData = try await model.fetchLoginData(container: LoginContainer(username: "emilys", password: "emilyspass"))
            print("\(loginData)\n\n")
            _ = try await getCurrentAuthUser(token: loginData.token)
        } catch let error {
            throw error
        }
        
        // Old code using nested clouser
//        model.fetchLoginData(container: LoginContainer(username: "emilys", password: "emilyspass")) { [weak self] result in
//            switch result {
//            case .success(let response):
//                if let response = response as? LoginDataModel {
//                    self?.getCurrentAuthUser(token: response.token)
//                }
//            case .failure(let error):
//                print(error?.localizedDescription ?? "")
//            }
//        }
    }
  
    func getCurrentAuthUser(token: String) async throws {
        
        do {
            let userData = try await model.fetchUserData(headerToken: token)
            print(userData)
        } catch let error {
            throw error
        }
        // Old code using nested clouser
        //    model.fetchUserData(headerToken: token) { result in
        //      switch result {
        //      case .success(let response):
        //        if let response = response as? UserDataModel {
        //          print(response)
        //        }
        //      case .failure(let error):
        //        print(error?.localizedDescription ?? "")
        //      }
        //    }
    }
}
