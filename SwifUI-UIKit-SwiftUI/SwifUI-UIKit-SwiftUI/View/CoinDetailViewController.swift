//
//  CoinDetailViewController.swift
//  SwifUI-UIKit-SwiftUI
//
//  Created by  Prince Shrivastav on 11/08/24.
//

import UIKit
import SwiftUI

class CoinDetailViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var lblName, lblCode, lblPrice, lblPercentage: UILabel!
    @IBOutlet weak var coinSymbol: UIImageView!
    
    // MARK: - Properties
    var viewModel: CoinDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        let coinsData = viewModel!.coinData
        lblCode.text = coinsData.symbol.uppercased()
        //coinSymbol.image = UIImage(data: Data.)
        lblName.text = coinsData.name
        lblPrice.text = coinsData.currentPrice.toCurrency()
        lblPercentage.text = coinsData.priceChangePercentage24H.description
        lblPercentage.textColor = coinsData.priceChangePercentage24H > 0 ? .green : .red
        
    }
    
    @IBAction func moveSwiftUIDetailView() {
        let view = CoinDetailView()
        let vc = UIHostingController(rootView: view.environmentObject(viewModel!))
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
