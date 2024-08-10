//
//  CoinModel.swift
//  CryptoCoins
//
//  Created by  Prince Shrivastav on 09/08/24.
//

import Foundation

class CoinModel {
    
    func getCryptoLivePrice(url: URL) async throws -> [CoinDataModel] {
        do {
           return try await NetworkManager.instance.fetchAPIRequest(type: CoinDataModel.self, from: url, httpMethod: .GET)
        } catch  {
            throw error
        }
    }
    
}
