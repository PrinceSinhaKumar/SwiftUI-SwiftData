//
//  CoinViewModel.swift
//  CryptoCoins
//
//  Created by  Prince Shrivastav on 09/08/24.
//

import Foundation

class CoinViewModel: ObservableObject {
    @Published var coinsData: [CoinDataModel] = []
    @Published var errorString: String?
    let BASE_URL = "https://api.coingecko.com/api/v3/coins/"
    let pageList = 20
    var pageNo = 0
    
    var urlString: String {
        return  "\(BASE_URL)markets?vs_currency=usd&order=market_cap_desc&per_page=\(pageList)&page=\(pageNo)&price_change_percentage=24h"
    }
    
    let model: CoinModel
    init(model: CoinModel) {
        self.model = model
        Task {
            await fetchLiveCoinPrice()
        }
    }
    
    @MainActor
    func fetchLiveCoinPrice() async {
        pageNo += 1
        guard let url = URL(string: urlString) else {
            return errorString = ErrorHandler.BadURLError.errorMessage
        }
        do {
            let coins = try await model.getCryptoLivePrice(url: url)
            coinsData.append(contentsOf: coins)
        } catch {
            errorString = (error as? ErrorHandler)?.errorMessage
        }
    }
    @MainActor
    func handleRefresh() async {
        pageNo = 0
        coinsData.removeAll()
        await fetchLiveCoinPrice()
    }
}
