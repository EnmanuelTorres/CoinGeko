//
//  SearchCryptoList.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import Foundation

protocol SearchCryptoListType {
    func execute(crypto: String) async -> Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError>
}

class SearchCryptoList: SearchCryptoListType{
    
    private let repository: SearchCryptoListBasicInfoRepositoryType
    
    init(repository: SearchCryptoListBasicInfoRepositoryType) {
        self.repository = repository
    }
    
    func execute(crypto: String) async -> Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> {
        let result = await repository.search(crypto: crypto)
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        return  .success(cryptoList.sorted { $0.name < $1.name })
    }
    
    
}
