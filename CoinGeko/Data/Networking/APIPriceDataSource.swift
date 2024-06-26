//
//  APIPriceDataSource.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import Foundation

class APIPriceDataSource: ApiPriceDataSourceType {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistoryDTO, HTTPClientError> {
      
        
        let queryParameters: [String : Any] = [
            "vs_currency" : "usd",
            "days" : days,
            "interval": "daily",
        ]
        
      let endPoint = Endpoint(path: "coins/\(id)/market_chart",
                              queryParameters: queryParameters,
                              method: .get)
        
      let result = await  httpClient.makeRequest(endpoint: endPoint,
                                                 baseUrl: "https://api.coingecko.com/api/v3/")
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let priceHistoryDTO = try? JSONDecoder().decode(CryptocurrencyPriceHistoryDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        
        return .success(priceHistoryDTO)
    }
    
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String : CryptocurrencyPriceInfoDTO], HTTPClientError> {
        
        let queryParameters: [String: Any] = [
            "ids" : id.joined(separator: ","),
            "vs_currencies" : "usd",
            "include_market_cap" : true,
            "include_24hr_vol" : true,
            "include_24hr_change" : true
        ]
        
        let endpoint = Endpoint(path: "simple/price",
                               queryParameters: queryParameters,
                               method: .get)
        
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingecko.com/api/v3/")
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let cryptoList = try? JSONDecoder().decode([String: CryptocurrencyPriceInfoDTO].self, from: data) else {
            return .failure(.parsingError)
        }
       
        return .success(cryptoList )
        
    }

    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }
        return error
    }
    
}
