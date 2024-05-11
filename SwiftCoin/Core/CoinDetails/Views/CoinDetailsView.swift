//
//  CoinDetailsView.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 02/05/24.
//

import SwiftUI

struct CoinDetailsView: View {
    let viewModel: CoinDetailViewModel
    
    init(coin: Coin) {
        self.viewModel = CoinDetailViewModel(coin: coin)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            // MARK: - Charts
            ChartView(viewModel: viewModel)
                .frame(height: 250)
                .padding(.vertical)
            
            // MARK: - Overview
            CoinDetailsSection(model: viewModel.overviewSectionModel)
                .padding(.vertical)
            
            // MARK: - Additional Details
            CoinDetailsSection(model: viewModel.additionalDetailSectionModel)
                .padding(.vertical)
        }
        .padding()
        .navigationTitle(viewModel.coinName)
    }
    
}

let coin = DeveloperPreview.instance.coin

#Preview {
    CoinDetailsView(coin: coin)
}
