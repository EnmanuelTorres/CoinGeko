//
//  searchCryptoListBasicInfoRepositoryTypeStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 10/04/24.
//

import Foundation
@testable import CoinGeko

class searchCryptoListBasicInfoRepositoryTypeStub: SearchCryptoListBasicInfoRepositoryType{
    private var result: Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError>
    
    init(result: Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError>){
        self.result = result
    }
    
    func search(crypto: String) async -> Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> {
        return result
    }
    
}
