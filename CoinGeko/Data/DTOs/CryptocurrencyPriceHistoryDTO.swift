//
//  CryptocurrencyPriceHistoryDTO.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import Foundation

struct CryptocurrencyPriceHistoryDTO: Codable {
    
    let prices: [[Double]]
    
    enum CodingKeys: String, CodingKey {
        case prices
    }
}
