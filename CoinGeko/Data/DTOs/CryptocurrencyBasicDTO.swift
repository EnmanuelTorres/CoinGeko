//
//  CryptocurrencyBasicDTO.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

struct CryptocurrencyBasicDTO: Codable{
    let  id: String
    let  symbol:  String
    let  name: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
    }
}
