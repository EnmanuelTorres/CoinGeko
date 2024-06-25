//
//  FilSwiftSDataContainerType.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 9/04/24.
//

import Foundation

protocol SwiftSDataContainerType {
    func fetchCryptos() -> [CryptocurrencyBasicInfoData]
    func insert(_ cryptoList: [CryptocurrencyBasicInfoData]) async
}
