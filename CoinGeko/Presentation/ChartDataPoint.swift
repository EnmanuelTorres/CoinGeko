//
//  ChartDataPoint.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 6/04/24.
//

import Foundation

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}
