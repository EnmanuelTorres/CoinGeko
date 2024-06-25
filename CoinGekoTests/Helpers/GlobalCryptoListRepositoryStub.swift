//
//  GlobalCryptoListRepositoryStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 10/04/24.
//

import Foundation
@testable import CoinGeko

class GlobalCryptoListRepositoryStub: GlobalCryptoListRepositoryType {
    private let result: Result<[Cryptocurrency], CryptocurrencyDomainError>
    
    init(result: Result<[Cryptocurrency], CryptocurrencyDomainError>) {
        self.result = result
    }
    
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptocurrencyDomainError> {
        return result
    }
}
