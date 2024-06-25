//
//  CacheCryptocurrencyBasicInfoDataSourceType.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import Foundation

protocol CacheCryptocurrencyBasicInfoDataSourceType {
    func getCryptoLis() async -> [CryptocurrencyBasicInfo]
    func saveCryptoList(_ cryptoList: [CryptocurrencyBasicInfo]) async
}
