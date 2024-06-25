//
//  SwiftDataCacheBasicInfoDataSource.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 9/04/24.
//

import Foundation

class SwiftDataCacheBasicInfoDataSource: CacheCryptocurrencyBasicInfoDataSourceType {
    private let container: SwiftSDataContainerType
    
    init(container: SwiftSDataContainerType) {
        self.container = container
    }
    
    func getCryptoLis() async -> [CryptocurrencyBasicInfo] {
        let cryptoList = container.fetchCryptos()
        return cryptoList.map{ CryptocurrencyBasicInfo(id: $0.id,
                                                name: $0.name,
                                                symbol: $0.symbol) }
    }
    
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async {
        
        let cryptoListData = cryptoList.map{ CryptocurrencyBasicInfoData(id: $0.id,
                                                                         name: $0.name,
                                                                         symbol: $0.symbol) }
       await container.insert(cryptoListData)
    }
    
}
