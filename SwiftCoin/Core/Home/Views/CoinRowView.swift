//
//  CoinRowView.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 01/05/24.
//

import SwiftUI
import Kingfisher

struct CoinRowView: View {
    let coin: Coin
    
    var body: some View {
        HStack {
            // MARK: - Market Cap Rank
            Text("\(coin.marketCapRank)")
                .font(.caption)
                .foregroundStyle(.gray)
            
            // MARK: - Image
//            Image(systemName: "bitcoinsign.circle.fill")
            KFImage(URL(string: coin.image))
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundStyle(.orange)
            
            // MARK: - Coin Name info
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading, 4)
                
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .padding(.leading, 4)
            }
            .foregroundStyle(Color.theme.primaryTextColor)
            .padding(.leading, 10)
            
            Spacer()
            
            // MARK: - Coin Price Info
            VStack(alignment: .trailing, spacing: 4) {
                Text(coin.currentPrice.toCurrency())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading, 4)
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Text(coin.priceChangePercentage24H.toPercentString())
                    .font(.caption)
                    .padding(.leading, 4)
                    .foregroundStyle(coin.priceChangePercentage24H > 0 ? .green : .red)
            }
            .padding(.leading, 10)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

//#Preview("CoinRowView", traits: .sizeThatFitsLayout) {
//    CoinRowView()
//        .padding()
//}
