//
//  GetPriceHistory.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import Foundation

class GetPriceHistory {
    
    private let repository: CryptocurrencyPriceHistoryRepositoryType
    
    init(repository: CryptocurrencyPriceHistoryRepositoryType) {
        self.repository = repository
    }
    
    func execute(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError>{
        
        return await repository.getPriceHistory(id: id, days: days)
    }
}
