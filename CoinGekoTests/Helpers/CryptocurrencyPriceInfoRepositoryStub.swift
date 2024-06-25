//
//  CryptocurrencyPriceInfoRepositoryStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 11/04/24.
//

import Foundation
@testable import CoinGeko

class CryptocurrencyPriceInfoRepositoryStub: CryptocurrencyPriceInfoRepositoryType {
    private let result : Result<CryptocurrencyPriceInfo, CryptocurrencyDomainError>
    
    init(result: Result<CryptocurrencyPriceInfo, CryptocurrencyDomainError>) {
        self.result = result
    }
    
    func getPriceInfo(Id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrencyDomainError> {
        return result
    }
}
