//
//  CoinDetailViewModel.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 02/05/24.
//

import Foundation
import SwiftUI

class CoinDetailViewModel {
    private let coin: Coin
    
    // MARK: - Chart Config
    var chartData = [ChartData]()
    var startDate = Date()
    var endDate = Date()
    var minPrice = 0.0
    var maxPrice = 0.0
    var xAxisValues = [Date]()
    var yAxisValues = [Double]()
    
    var coinName: String {
        return coin.name
    }
    
    var chartLineColor: Color {
        let lastPrice = coin.sparklineIn7D?.price.last ?? 0
        let firstPrice = coin.sparklineIn7D?.price.first ?? 0
        let priceChange = lastPrice - firstPrice
        
        return priceChange > 0 ? .green : .red
    }
    
    
    var overviewSectionModel: CoinDetailSectionModel {
        // MARK: - Price stats
        let priceStats = StatisticModel(
            title: "Current Price",
            value: coin.currentPrice.toCurrency(),
            percentageChange: coin.priceChangePercentage24H
        )
        
        // MARK: - market Cap Stats
        let marketCapStats = StatisticModel(
            title: "Market Cap",
            value: (coin.marketCap ?? 0).formattedWithAbbreviations(),
            percentageChange: coin.marketCapChangePercentage24H
        )
        
        // MARK: - Rank stats
        let rankStats = StatisticModel(
            title: "Rank",
            value: String(coin.marketCapRank),
            percentageChange: nil
        )
        
        // MARK: - Volume Stats
        let volumeStats = StatisticModel(
            title: "Volume",
            value: (coin.totalVolume ?? 0).formattedWithAbbreviations(),
            percentageChange: nil
        )
        
        return CoinDetailSectionModel(title: "Overview", stats: [priceStats, marketCapStats, rankStats, volumeStats])
    }
    var additionalDetailSectionModel: CoinDetailSectionModel {
        // MARK: - 24 high
        let high24H = StatisticModel(
            title: "24h high",
            value: coin.high24H?.toCurrency() ?? "n/a",
            percentageChange: nil
        )
        
        // MARK: - 24h low
        let low24h = StatisticModel(
            title: "24h low",
            value: coin.low24H?.toCurrency() ?? "n/z",
            percentageChange: nil
        )
        
        // MARK: - 24h Price change
        let priceChange24h = StatisticModel(
            title: "24h Price Change",
            value: coin.priceChange24H.toCurrency(),
            percentageChange: coin.priceChangePercentage24H
        )
        
        // MARK: - 24h market cap change
        let marketCapChange = StatisticModel(
            title: "24h Market Cap Change",
            value: "$\((coin.marketCapChange24H ?? 0).formattedWithAbbreviations())",
            percentageChange: coin.marketCapChangePercentage24H
        )
        return CoinDetailSectionModel(
            title: "Additional Details",
            stats: [high24H, low24h, priceChange24h, marketCapChange]
        )
    }
    
    init(coin: Coin) {
        self.coin = coin
        configureChartData()
        
        print(coin.name)
    }
    
    func configureChartData() {
        guard let priceData = coin.sparklineIn7D?.price else { return }
        var index = 0
        self.minPrice = priceData.min()!
        self.maxPrice = priceData.max()!
        self.endDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        self.startDate = endDate.addingTimeInterval(-7 * 60 * 60 * 24)
        self.yAxisValues = [minPrice, (minPrice + maxPrice) / 2, maxPrice]
        self.xAxisValues = [startDate, endDate]
        
        for price in priceData.reversed() {
            let date = endDate.addingTimeInterval(-1 * 60 * 60 * Double(index))
            
            let chartDataItem = ChartData(date: date, value: price)
            self.chartData.append(chartDataItem)
            index += 1
        }
    }
}
