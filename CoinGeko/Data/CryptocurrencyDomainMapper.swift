//
//  CryptocurrencyDomainMapper.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

class CryptocurrencyDomainMapper{
    
    func getCryptocurrencyBuilderList(symbolList: [String], cryptoList: [CryptocurrencyBasicDTO]) -> [CryptocurrencyBuilder] {
        var symbolListDic = [String: Bool]()
        symbolList.forEach { symbol in
            symbolListDic[symbol] = true
        }
        
        let globalCryptoList = cryptoList.filter{ symbolListDic[$0.symbol] ?? false }
        
        let cryptocurrencyBuilderList = globalCryptoList.map{        CryptocurrencyBuilder(id: $0.id,
                                                                                           name: $0.name,
                                                                                           symbol: $0.symbol)
        }
        
        return cryptocurrencyBuilderList
    }
    
    func map(cryptocurrencyBuilderList: [CryptocurrencyBuilder], priceInfo: [String: CryptocurrencyPriceInfoDTO] ) -> [Cryptocurrency] {
        cryptocurrencyBuilderList.forEach { CryptocurrencyBuilder in
            if let priceInfo = priceInfo[CryptocurrencyBuilder.id] {
                CryptocurrencyBuilder.price = priceInfo.price
                CryptocurrencyBuilder.volume24h = priceInfo.volume24h
                CryptocurrencyBuilder.marketCap = priceInfo.marketCap
                CryptocurrencyBuilder.price24h = priceInfo.price24h
            }
        }
        
        return cryptocurrencyBuilderList.compactMap{ $0.build() }
    }
    
}
