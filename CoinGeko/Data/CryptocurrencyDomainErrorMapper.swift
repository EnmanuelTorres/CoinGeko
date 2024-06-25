//
//  CryptocurrencyDomainErrorMapper.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

class CryptocurrencyDomainErrorMapper {
    func map(error: HTTPClientError?) -> CryptocurrencyDomainError {
        guard error == .tooManyRequests else {
            return .generic
        }
        return .tooManyRequests
    }
}
