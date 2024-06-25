//
//  CryptocurrencyGlobalInfoDTO.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

struct CryptocurrencyGlobalInfoDTO: Codable {
    let data: CryptocurrencyGlobalData
    
    struct CryptocurrencyGlobalData: Codable {
        
        let cryptocurrency: [String: Double]
        
        enum CodingKeys:  String, CodingKey {
            case cryptocurrency = "market_cap_percentage"
        }
    }
}
