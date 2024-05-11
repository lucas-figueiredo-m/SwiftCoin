//
//  ChartData.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 03/05/24.
//

import Foundation

struct ChartData: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let value: Double
}
