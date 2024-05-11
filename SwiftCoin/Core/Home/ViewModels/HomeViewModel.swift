//
//  HomeViewModel.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 02/05/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var topMovingCoins = [Coin]()
    @Published var isLoadingData = true
    
    static private let baseUrl: String = "https://api.coingecko.com/api/v3"
    
    private func buildRequestPath(path: String) -> String {
        return HomeViewModel.baseUrl + path
    }
    
    init() {
        fetchCoinData()
    }
    
    func fetchCoinData() {
        let path = buildRequestPath(path: "/coins/markets")
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "100"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "price_change_percentage", value: "24h"),
            
        ]
        guard let url = URL(string: path)?.appending(queryItems: queryItems) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        request.setValue("CG-EfGM6DNHpsNYo4TPQZN7NBLt", forHTTPHeaderField:"x-cg-demo-api-key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("DEBUG: Error \(error.localizedDescription)")
                self.isLoadingData = false
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("DEBUG: Response Code \(response.statusCode)")
            }
            
            guard let data = data else { return }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                DispatchQueue.main.async {
                    self.coins = coins
                    self.configureTopMovingCoins()
                    self.isLoadingData = false
                }
            } catch let error {
                print("DEBUG: Faield do decode with error \(error)")
                self.isLoadingData = false
            }
            
        }.resume()
        
    }
    
    func configureTopMovingCoins() {
        let topMovers = coins.sorted { $0.priceChangePercentage24H > $1.priceChangePercentage24H }
        self.topMovingCoins = Array(topMovers.prefix(5))
    }
}



// https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h

// --header 'x-cg-demo-api-key: CG-EfGM6DNHpsNYo4TPQZN7NBLt'
