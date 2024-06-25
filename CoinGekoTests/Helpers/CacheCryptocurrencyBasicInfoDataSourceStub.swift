//
//  CacheCryptocurrencyBasicInfoDataSourceStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 13/04/24.
//

import Foundation
@testable import CoinGeko


class CacheCryptocurrencyBasicInfoDataSourceStub: CacheCryptocurrencyBasicInfoDataSourceType {
    
    private let getCryptoList: [CryptocurrencyBasicInfo]
    var cachedCryptoList: [CryptocurrencyBasicInfo]?
    
    init(getCryptoList: [CryptocurrencyBasicInfo]) {
        self.getCryptoList = getCryptoList
    }
    
    func getCryptoLis() async -> [CryptocurrencyBasicInfo] {
        return getCryptoList
    }
    
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async {
        cachedCryptoList = cryptoList
    }
    
    
}
