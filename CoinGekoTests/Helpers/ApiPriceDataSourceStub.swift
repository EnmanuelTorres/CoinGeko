//
//  ApiPriceDataSourceStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 13/04/24.
//

import Foundation
@testable import CoinGeko

class ApiPriceDataSourceStub: ApiPriceDataSourceType {
    
    var getPriceHistory: Result<CryptocurrencyPriceHistoryDTO, HTTPClientError>?
    var getPriceInfoForCryptos:  Result<[String : CryptocurrencyPriceInfoDTO], HTTPClientError>?
    
    
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistoryDTO, HTTPClientError> {
        return getPriceHistory!
    }
    
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String : CryptocurrencyPriceInfoDTO], HTTPClientError> {
        return getPriceInfoForCryptos!
    }
    
    
}
