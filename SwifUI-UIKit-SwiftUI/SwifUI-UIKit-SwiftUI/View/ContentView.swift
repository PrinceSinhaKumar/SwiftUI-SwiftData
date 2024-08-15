//
//  ContentView.swift
//  CryptoCoins
//
//  Created by  Prince Shrivastav on 08/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinViewModel(model: CoinModel())
    @State var showAlert = false
    var data: [String] = ["aaa","aaa","aaa","aaa"]
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(viewModel.coinsData) { coin in
                        NavigationLink {
                            CoinDetailViewControllerRepersentable(coinData: coin)
                        } label: {
                            CoinList(coin: coin)
                                .padding([.top, .bottom], 3)
                                .onAppear {
                                    if viewModel.coinsData.last?.id == coin.id {
                                        Task {
                                            await viewModel.fetchLiveCoinPrice()
                                        }
                                    }
                                }
                        }
                        
                    }
                }
                .refreshable(action: {
                    await viewModel.handleRefresh()
                })
                .navigationTitle("Live Prices")
            }
        }
        .onReceive(viewModel.$errorString, perform: { error in
            if error != nil {
                showAlert.toggle()
            }
        })
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("||Error||"), message: Text(viewModel.errorString ?? ""))
        })
        
    }
}

#Preview {
    ContentView()
}

struct CoinList: View {
    var coin: CoinDataModel
    var body: some View {
        HStack {
            Text(coin.marketCapRank.description)
                .font(.system(size: 10, weight: .regular))
                .foregroundStyle(Color.gray)
            AsyncImage(url: coin.imageUrl, content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
            }) {
                Image(systemName: "bitcoinsign.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
            }
                
            VStack(alignment: .leading,spacing: 2, content: {
                Text(coin.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.black)
                
                Text(coin.symbol.uppercased())
                    .font(.system(size: 10, weight: .regular))
                    .foregroundStyle(Color(uiColor: UIColor.black.withAlphaComponent(0.8)))
            })
            Spacer()
            VStack(alignment: .trailing,spacing: 2, content: {
                Text(coin.currentPrice.toCurrency())
                    .font(.system(size: 14, weight: .semibold))
                Text(coin.priceChangePercentage24H.description)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(coin.priceChangePercentage24H > 0 ? .green : .red)
            })
        }
    }
}
import UIKit
struct CoinDetailViewControllerRepersentable: UIViewControllerRepresentable {
    
    let coinData: CoinDataModel
    func makeUIViewController(context: Context) -> some UIViewController {
        let coinDetailViewModel = CoinDetailViewModel(coinData: coinData)
        let vc = UIStoryboard(name: "CoinDetailStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CoinDetailViewController") as! CoinDetailViewController
        vc.viewModel = coinDetailViewModel
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
