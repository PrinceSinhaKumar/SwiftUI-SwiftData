//
//  CoinDetailView.swift
//  SwifUI-UIKit-SwiftUI
//
//  Created by  Prince Shrivastav on 12/08/24.
//

import SwiftUI

struct CoinDetailView: View {
    
    @EnvironmentObject var viewModel: CoinDetailViewModel
    
    var body: some View {
        VStack {
            HStack{
                AsyncImage(url: viewModel.coinData.imageUrl, content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                }) {
                    Image(systemName: "bitcoinsign.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                }
            }
            
            HStack {
                let coinData = viewModel.coinData
                VStack(alignment: .leading,spacing: 2, content: {
                    Text(coinData.name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.black)
                    
                    Text(coinData.symbol.uppercased())
                        .font(.system(size: 10, weight: .regular))
                        .foregroundStyle(Color(uiColor: UIColor.black.withAlphaComponent(0.8)))
                })
                Spacer()
                VStack(alignment: .trailing,spacing: 2, content: {
                    Text(coinData.currentPrice.toCurrency())
                        .font(.system(size: 14, weight: .semibold))
                    Text(coinData.priceChangePercentage24H.description)
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(coinData.priceChangePercentage24H > 0 ? .green : .red)
                })
            }
        }
    }
}

//#Preview {
//    CoinDetailView(viewModel: )
//}
