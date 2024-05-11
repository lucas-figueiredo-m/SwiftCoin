//
//  CoinDetailsSection.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 02/05/24.
//

import SwiftUI

struct CoinDetailsSection: View {
    let model: CoinDetailSectionModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            Text(model.title)
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                ForEach(model.stats) { stat in
                    StatisticView(model: stat)
                    
                }
                
            }
        }
    }
}

let model = DeveloperPreview.instance.sectionModel

#Preview {
    CoinDetailsSection(model: model)
}
