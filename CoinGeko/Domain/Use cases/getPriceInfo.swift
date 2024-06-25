//
//  getPriceInfo.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 9/04/24.
//

import Foundation

protocol getPriceInfoType {
    func execute(id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrencyDomainError>
}

class getPriceInfo: getPriceInfoType {
    
    private let repository: CryptocurrencyPriceInfoRepositoryType
    
    init(repository: CryptocurrencyPriceInfoRepositoryType) {
        self.repository = repository
    }
    
    func execute(id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrencyDomainError> {
       return await repository.getPriceInfo(Id: id)
    }
}
