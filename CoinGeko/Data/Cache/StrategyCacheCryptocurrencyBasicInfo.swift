//
//  StrategyCacheCryptocurrencyBasicInfo.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 10/04/24.
//

import Foundation

class StrategyCacheCryptocurrencyBasicInfo: CacheCryptocurrencyBasicInfoDataSourceType {
    
    private let temporalCache: CacheCryptocurrencyBasicInfoDataSourceType
    private let persistenceCache: CacheCryptocurrencyBasicInfoDataSourceType
    
    init(temporalCache: CacheCryptocurrencyBasicInfoDataSourceType,
         persistenceCache: CacheCryptocurrencyBasicInfoDataSourceType) {
        self.temporalCache = temporalCache
        self.persistenceCache = persistenceCache
    }
    func getCryptoLis() async -> [CryptocurrencyBasicInfo] {
        let temporalCryptoList = await temporalCache.getCryptoLis()
        
        if !temporalCryptoList.isEmpty {
            return temporalCryptoList
        }
        
        let persistenceCryptoList = await persistenceCache.getCryptoLis()
        await temporalCache.saveCryptoList(persistenceCryptoList)
        
        return persistenceCryptoList
        
    }
    
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async {
        await temporalCache.saveCryptoList(cryptoList)
        await persistenceCache.saveCryptoList(cryptoList)
    }
    
}
