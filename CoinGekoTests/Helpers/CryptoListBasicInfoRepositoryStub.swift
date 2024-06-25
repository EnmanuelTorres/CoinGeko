//
//  CryptoListBasicInfoRepositoryStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 11/04/24.
//

import Foundation
@testable import CoinGeko

class CryptoListBasicInfoRepositoryStub: CryptoListBasicInfoRepositoryType {
    
    let result: Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError>
    
    init(result: Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError>) {
        self.result = result
    }
    
    func getCryptoList() async -> Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> {
        return result
    }
    
    
}
