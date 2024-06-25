//
//  CryptocurrencyPriceHistoryRepositoryType.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import Foundation

protocol CryptocurrencyPriceHistoryRepositoryType {
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError>
}
