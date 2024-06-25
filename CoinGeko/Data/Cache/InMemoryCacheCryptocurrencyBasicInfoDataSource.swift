//
//  InMemoryCacheCryptocurrencyBasicInfoDataSource.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import Foundation

actor InMemoryCacheCryptocurrencyBasicInfoDataSource: CacheCryptocurrencyBasicInfoDataSourceType {
    
    static let shared: InMemoryCacheCryptocurrencyBasicInfoDataSource = InMemoryCacheCryptocurrencyBasicInfoDataSource()
    private init(){}
    
    private var cache: [CryptocurrencyBasicInfo] = []
    
    func getCryptoLis() async -> [CryptocurrencyBasicInfo] {
        return cache
    }
    
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async {
        self.cache = cryptoList
    }
    
}
