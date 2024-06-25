//
//  CryptocurrencyPriceRepository.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import Foundation

class CryptocurrencyPriceRepository: CryptocurrencyPriceHistoryRepositoryType {
    private let apiDataSource: ApiPriceDataSourceType
    private let domainMapper: CryptocurrencyPriceHistoryDomainMapper
    private let errorMapper: CryptocurrencyDomainErrorMapper
    
    init(apiDataSource: ApiPriceDataSourceType,
         domainMapper: CryptocurrencyPriceHistoryDomainMapper,
         errorMapper: CryptocurrencyDomainErrorMapper
        ) {
        self.apiDataSource = apiDataSource
        self.domainMapper = domainMapper
        self.errorMapper = errorMapper
    }
    
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError> {
     let result =  await apiDataSource.getPriceHistory(id: id, days: days)
        
        guard case .success(let priceHistory) = result else {
            return .failure(errorMapper.map(error: result.failureValue as? HTTPClientError))
        }

        return .success(domainMapper.map(priceHistoryDTO: priceHistory))
    }
    
    
}

extension CryptocurrencyPriceRepository:  CryptocurrencyPriceInfoRepositoryType{
    func getPriceInfo(Id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrencyDomainError> {
        let result = await  apiDataSource.getPriceInfoForCryptos(id: [Id])
        
        guard case .success(let priceInfoDictionary) = result else {
            return .failure(errorMapper.map(error: result.failureValue as? HTTPClientError))
        }
        
        guard let priceInfo = priceInfoDictionary.values.first else {
            return .failure(.generic)
        }
        
        let priceInfoDomain = CryptocurrencyPriceInfo(price: priceInfo.price ?? Double(0),
                                                      price24h: priceInfo.price24h ?? 0,
                                                      volume24h: priceInfo.volume24h,
                                                      marketCap: priceInfo.marketCap ?? Double(0))
        
        return .success(priceInfoDomain)

    }
    
    
}
