//
//  CryptocurrencyBasicInfoData.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 9/04/24.
//

import Foundation
import SwiftData

@Model
class CryptocurrencyBasicInfoData {
    let id: String
    let name: String
    let symbol: String
    
    init(id: String, name: String, symbol: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
    }
}
