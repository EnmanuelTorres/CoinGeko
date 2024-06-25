//
//  GetCryptoList.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 7/04/24.
//

import Foundation

protocol GetCryptoListType{
    func execute() async -> Result<[CryptocurrencyBasicInfo],  CryptocurrencyDomainError>
    
}

class GetCryptoList: GetCryptoListType {
    
    private let repository: CryptoListBasicInfoRepositoryType
    
    init(repository: CryptoListBasicInfoRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> {
        let result = await repository.getCryptoList()
        
        guard let cryptoList = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            return .failure(error)
        }
        
        return  .success(cryptoList.sorted { $0.name < $1.name })
    }
    
    
    
}
