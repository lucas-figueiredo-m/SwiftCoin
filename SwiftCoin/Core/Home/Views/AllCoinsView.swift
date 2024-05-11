//
//  AllCoinsView.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 01/05/24.
//

import SwiftUI

struct AllCoinsView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Coins")
                .font(.headline)
                .padding()
            
            HStack {
                Text("Coin")
                
                Spacer()
                
                Text("Prices")
            }
            .foregroundStyle(.gray)
            .font(.caption)
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ForEach(viewModel.coins) { coin in
                        NavigationLink {
                            LazyNavigationView(CoinDetailsView(coin: coin))
                            
                        } label: {
                            CoinRowView(coin: coin)
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    AllCoinsView()
//}
