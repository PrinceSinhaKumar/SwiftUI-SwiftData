//
//  LoginDataModel.swift
//  ConcurrencySwift
//
//  Created by Priyanka Mathur on 03/08/24.
//

import Foundation

struct LoginContainer: Encodable {
  let username: String
  let password: String
}

struct LoginDataModel: Decodable {
  let id: Int
  let username: String
  let email: String
  let firstName: String
  let lastName: String
  let gender: String
  let image: String
  let token: String
  let refreshToken: String
}

struct UserDataModel: Decodable {

  let id: Int?
  let firstName: String?
  let lastName: String?
  let maidenName: String?
  let age: Int?
  let gender: String?
  let email: String?
  let phone: String?
  let username: String?
  let password: String?
  let birthDate: String?
  let image: String?
  let bloodGroup: String?
  let height: Double?
  let weight: Double?
  let eyeColor: String?
  let hair: Hair?
  let ip: String?
  let address: Address?
  let macAddress: String?
  let university: String?
  let bank: Bank?
  let company: Company?
  let ein: String?
  let ssn: String?
  let userAgent: String?
  let crypto: Crypto?
  let role: String?

}
struct Hair: Decodable {

  let color: String?
  let type: String?

}

struct Address: Decodable {
  let address: String?
  let city: String?
  let state: String?
  let stateCode: String?
  let postalCode: String?
  let country: String?
}
struct Bank: Decodable {

  let cardExpire: String?
  let cardNumber: String?
  let cardType: String?
  let currency: String?
  let iban: String?

}

struct Company: Decodable {

  let department: String?
  let name: String?
  let title: String?
  let address: Address?

}
struct Crypto: Decodable {

  let coin: String?
  let wallet: String?
  let network: String?

}
