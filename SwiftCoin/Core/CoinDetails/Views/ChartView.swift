//
//  ChartView.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 03/05/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    let viewModel: CoinDetailViewModel
    var body: some View {
        Chart {
            ForEach(viewModel.chartData) { item in
                LineMark(
                    x: .value("Date", item.date),
                    y: .value("Price", item.value)
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(viewModel.chartLineColor)
                .shadow(color: viewModel.chartLineColor, radius: 10)
                .shadow(color: viewModel.chartLineColor.opacity(0.5), radius: 10)
            }
        }
        .chartXScale( domain: ClosedRange(
                uncheckedBounds: (
                    lower: viewModel.startDate,
                    upper: viewModel.endDate
                )
        ))
        .chartXAxis {
            AxisMarks(
                position: .bottom,
                values: viewModel.xAxisValues) { value in
                    AxisGridLine()
                    AxisValueLabel() {
                        if let dateValue = value.as(Date.self) {
                            Text(dateValue.asShortDateString())
                        }
                    }
                }
        }
        .chartYScale(domain: ClosedRange (
            uncheckedBounds: (
                lower: viewModel.minPrice,
                upper: viewModel.maxPrice
            )
        ))
        .chartYAxis {
            AxisMarks(
                position: .leading,
                values: viewModel.yAxisValues) { value in
                    AxisGridLine()
                    AxisValueLabel() {
                        if let doubleValue = value.as(Double.self) {
                            Text(doubleValue.formattedWithAbbreviations())
                        }
                    }
                }
        }
    }
}

let viewModel = CoinDetailViewModel(coin: DeveloperPreview.instance.coin)

#Preview {
    ChartView(viewModel: viewModel)
}
