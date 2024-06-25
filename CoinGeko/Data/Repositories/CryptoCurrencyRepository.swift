//
//  CryptoCurrencyRepository.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

class CryptoCurrencyRepository: GlobalCryptoListRepositoryType {
    
    private let apiDatasourcePriceInfo: ApiDatasourcePriceInfoType
    private let apiDatasourceSymbol: ApiDatasourceSymbolType
    private let apiDatasourceCrypto: ApiDatasourceCryptoType

    private let  errorMapper: CryptocurrencyDomainErrorMapper
    private let domainMapper: CryptocurrencyDomainMapper
    
    init(apiDatasourcePriceInfo: ApiDatasourcePriceInfoType,
         apiDatasourceSymbol: ApiDatasourceSymbolType,
         apiDatasourceCrypto: ApiDatasourceCryptoType,
         errorMapper: CryptocurrencyDomainErrorMapper,
         domainMapper: CryptocurrencyDomainMapper
    ){
        self.apiDatasourcePriceInfo = apiDatasourcePriceInfo
        self.apiDatasourceSymbol = apiDatasourceSymbol
        self.apiDatasourceCrypto = apiDatasourceCrypto
        self.errorMapper = errorMapper
        self.domainMapper = domainMapper
    }
    
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptocurrencyDomainError> {
        
        let symbolListResult = await apiDatasourceSymbol.getGlobalCryptoSymbolList()
        let cryptoListResult = await apiDatasourceCrypto.getCryptoLis()
        
        guard case .success(let symbolList) = symbolListResult else {
         return .failure(errorMapper.map(error: symbolListResult.failureValue as? HTTPClientError))
        }
        
        guard case .success(let cryptoList) = cryptoListResult else {
            return .failure(errorMapper.map(error: cryptoListResult.failureValue as? HTTPClientError))
        }

        
        let cryptocurrencyBuilderList = domainMapper.getCryptocurrencyBuilderList(symbolList: symbolList, cryptoList: cryptoList)
       
        let priceInfoResult = await apiDatasourcePriceInfo.getPriceInfoForCryptos(id:  cryptocurrencyBuilderList.map{ $0.id} )
        
        guard case .success(let priceInfo) = priceInfoResult else {
            return .failure(errorMapper.map(error: priceInfoResult.failureValue as? HTTPClientError))
        }
        
       let cryptocurrency = domainMapper.map(cryptocurrencyBuilderList: cryptocurrencyBuilderList, priceInfo: priceInfo)
        
        return .success(cryptocurrency)
    }
    
    
}
