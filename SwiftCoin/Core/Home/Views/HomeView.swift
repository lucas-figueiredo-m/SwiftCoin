//
//  HomeView.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 01/05/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    // MARK: - Top movers view
                    TopMoversView(viewModel: viewModel)
                    
                    Divider()
                    
                    // MARK: - All Coins View
                    AllCoinsView(viewModel: viewModel)
                }
                
                if viewModel.isLoadingData {
                    CustomLoadingIndicator()
                }
            }
            .navigationTitle("Live Prices")
        }
    }
}

#Preview {
    HomeView()
}
