//
//  CryptocurrencyBasicInfoRepository.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import Foundation

class CryptocurrencyBasicInfoRepository: CryptoListBasicInfoRepositoryType {
    
    private let apiDatasource: APICryptocurrencyBasicInfoDataSourceType
    private let  errorMapper: CryptocurrencyDomainErrorMapper
    private let cacheDatasource: CacheCryptocurrencyBasicInfoDataSourceType
    
    init(apiDatasource: APICryptocurrencyBasicInfoDataSourceType,
         errorMapper: CryptocurrencyDomainErrorMapper,
         cacheDatasource: CacheCryptocurrencyBasicInfoDataSourceType ) {
        self.apiDatasource = apiDatasource
        self.errorMapper = errorMapper
        self.cacheDatasource = cacheDatasource
    }
    
    func getCryptoList() async -> Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> {
        let cryptoListCache = await cacheDatasource.getCryptoLis()
        
        if !cryptoListCache.isEmpty {
            return .success(cryptoListCache)
        }
        
        let cryptoListResult = await apiDatasource.getCryptoLis()
        
        guard case .success(let cryptoList) = cryptoListResult else {
            return .failure(errorMapper.map(error: cryptoListResult.failureValue as? HTTPClientError))
        }
        
      let cryptoListDomain = cryptoList.map { CryptocurrencyBasicInfo(id: $0.id, name: $0.name, symbol: $0.symbol)}
        
       await cacheDatasource.saveCryptoList(cryptoListDomain)
        
        return .success(cryptoListDomain)
    }
    
}

extension CryptocurrencyBasicInfoRepository: SearchCryptoListBasicInfoRepositoryType {
    func search(crypto: String) async -> Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError> {
        let result = await getCryptoList()
        
        guard case .success(let cryptoList) = result else {
            return result
        }
        
        guard crypto != "" else {
            return result
        }

        let filteredCryptoList = cryptoList.filter{ $0.name.lowercased().contains(crypto.lowercased()) ||                  $0.symbol.lowercased().contains(crypto.lowercased()) }
        
        return .success(filteredCryptoList)
    }
}
