//
//  GetGlobalCryptoList.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

protocol GetGlobalCryptoListType {
    func execute() async -> Result<[Cryptocurrency], CryptocurrencyDomainError>
}

class GetGlobalCryptoList: GetGlobalCryptoListType {
    
    private let repository: GlobalCryptoListRepositoryType
    
    init(repository: GlobalCryptoListRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<[Cryptocurrency], CryptocurrencyDomainError> {
        let result = await repository.getGlobalCryptoList()
        
        guard let cryptoList =  try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        return .success(cryptoList.sorted{$0.marketCap > $1.marketCap })
    }
}
