//
//  StatisticView.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 02/05/24.
//

import SwiftUI

struct StatisticView: View {
    let model: StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.title)
                .font(.caption)
            
            Text(model.value)
                .font(.headline)
            
            if let percentageChange = model.percentageChange {
                HStack(spacing: 4) {
                    Image(systemName: "triangle.fill")
                        .font(.caption)
                    
                    Text(percentageChange.toPercentString())
                        .font(.caption)
                        .bold()
                }
                .foregroundStyle(.green)
            }
            
        }
    }
}

let stat = DeveloperPreview.instance.stat1
#Preview("StatisticView", traits: .sizeThatFitsLayout) {
    StatisticView(model: stat)
        .padding()
}
