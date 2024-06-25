//
//  APICryptocurrencyBasicInfoDataSourceStub.swift
//  CoinGekoTests
//
//  Created by ENMANUEL TORRES on 13/04/24.
//

import Foundation
@testable import CoinGeko

class APICryptocurrencyBasicInfoDataSourceStub: APICryptocurrencyBasicInfoDataSourceType {
    private let result: Result<[CryptocurrencyBasicDTO], HTTPClientError>
    
    init(result: Result<[CryptocurrencyBasicDTO], HTTPClientError>) {
        self.result = result
    }
    func getCryptoLis() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError> {
        return result
    }
    
}
