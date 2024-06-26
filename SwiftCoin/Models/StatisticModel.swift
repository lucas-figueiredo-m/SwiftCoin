//
//  StatisticModel.swift
//  SwiftCoin
//
//  Created by Lucas Martins Figueiredo on 02/05/24.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
}
