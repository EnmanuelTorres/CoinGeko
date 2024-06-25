//
//  APICryptocurrencyBasicInfoDataSourceType.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import Foundation

protocol APICryptocurrencyBasicInfoDataSourceType {
    func getCryptoLis() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
}
