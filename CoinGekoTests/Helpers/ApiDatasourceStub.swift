//
//  ApiDatasourceStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 13/04/24.
//

import Foundation
@testable import CoinGeko

class ApiDatasourceStub  {
    
    private let globalCryptoSymbolList: Result<[String], HTTPClientError>
    private let cryptoList:  Result<[CryptocurrencyBasicDTO], HTTPClientError>
    private let priceInfo:  Result<[String: CryptocurrencyPriceInfoDTO], HTTPClientError>
    
    init(globalCryptoSymbolList: Result<[String], HTTPClientError>, cryptoList: Result<[CryptocurrencyBasicDTO], HTTPClientError>, priceInfo: Result<[String : CryptocurrencyPriceInfoDTO], HTTPClientError>) {
        self.globalCryptoSymbolList = globalCryptoSymbolList
        self.cryptoList = cryptoList
        self.priceInfo = priceInfo
    }
}

extension ApiDatasourceStub: ApiDatasourceCryptoType {
    func getCryptoLis() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError> {
        return cryptoList
    }
}
    
extension ApiDatasourceStub: ApiDatasourceSymbolType {
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError> {
        return globalCryptoSymbolList
    }
}
    
extension ApiDatasourceStub: ApiDatasourcePriceInfoType {
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptocurrencyPriceInfoDTO], HTTPClientError> {
        return priceInfo
    }
}
