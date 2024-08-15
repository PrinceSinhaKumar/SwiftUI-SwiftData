//
//  CoinDetailViewModel.swift
//  SwifUI-UIKit-SwiftUI
//
//  Created by  Prince Shrivastav on 11/08/24.
//

import Foundation

class CoinDetailViewModel: ObservableObject {
    @Published var coinData: CoinDataModel
    init(coinData: CoinDataModel) {
        self.coinData = coinData
    }
    
}
