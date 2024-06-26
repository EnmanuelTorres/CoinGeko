//
//  Equatable.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 10/04/24.
//

import Foundation
@testable import CoinGeko

extension CryptocurrencyBasicInfo: Equatable {
   public static func == (lhs: CryptocurrencyBasicInfo, rhs: CryptocurrencyBasicInfo) -> Bool {
       return lhs.id == rhs.id
       && lhs.name == rhs.name
       && lhs.symbol == rhs.symbol
    }
}


extension Cryptocurrency: Equatable {
   public static func == (lhs: Cryptocurrency, rhs: Cryptocurrency) -> Bool {
        return lhs.id == rhs.id
               && lhs.name == rhs.name
               && lhs.symbol == rhs.symbol
               && lhs.price == rhs.price
               && lhs.price24h == rhs.price24h
               && lhs.volume24h == rhs.volume24h
               && lhs.marketCap == rhs.marketCap
    }
}


extension CryptocurrencyPriceInfo: Equatable {
   public static func == (lhs: CryptocurrencyPriceInfo, rhs: CryptocurrencyPriceInfo) -> Bool {
        return lhs.price == rhs.price
               && lhs.price24h == rhs.price24h
               && lhs.volume24h == rhs.volume24h
               && lhs.marketCap == rhs.marketCap
    }
}

extension CryptocurrencyPriceHistory: Equatable {
   public static func == (lhs: CoinGeko.CryptocurrencyPriceHistory, rhs: CoinGeko.CryptocurrencyPriceHistory) -> Bool {
        return lhs.prices == rhs.prices
    }
    
    
}

extension CryptocurrencyPriceHistory.DataPoint: Equatable {
    public static func == (lhs: CryptocurrencyPriceHistory.DataPoint, rhs: CryptocurrencyPriceHistory.DataPoint) -> Bool {
        return  lhs.price == rhs.price && lhs.date == rhs.date
    }
    
    
}

extension CryptocurrencyPriceHistoryDTO: Equatable {
    public static func == (lhs: CryptocurrencyPriceHistoryDTO, rhs: CryptocurrencyPriceHistoryDTO) -> Bool {
        lhs.prices == rhs.prices
    }
    
}

extension CryptocurrencyBasicDTO: Equatable {
   public static func == (lhs: CryptocurrencyBasicDTO, rhs: CryptocurrencyBasicDTO) -> Bool {
        lhs.id == rhs.id
    }
}



extension CryptocurrencyPriceInfoDTO: Equatable {
   public static func == (lhs: CryptocurrencyPriceInfoDTO, rhs: CryptocurrencyPriceInfoDTO) -> Bool {
        lhs.price == rhs.price
        && lhs.marketCap == rhs.marketCap
        && lhs.volume24h == rhs.volume24h
        && lhs.price24h == rhs.price24h
    }
}
