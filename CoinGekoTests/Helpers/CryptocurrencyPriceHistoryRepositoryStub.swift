//
//  CryptocurrencyPriceHistoryRepositoryStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 11/04/24.
//

import Foundation
@testable import CoinGeko

class CryptocurrencyPriceHistoryRepositoryStub: CryptocurrencyPriceHistoryRepositoryType {
    let result:  Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError>
    
    init(result: Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError>) {
        self.result = result
    }
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError> {
        return result
    }
    
    
}
