//
//  CryptoListBasicInfoRepositoryType.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import Foundation

protocol CryptoListBasicInfoRepositoryType {
    func getCryptoList() async -> Result<[CryptocurrencyBasicInfo],  CryptocurrencyDomainError>
}
