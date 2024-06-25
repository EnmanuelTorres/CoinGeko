//
//  CryptocurrencyPresentableMapper.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import Foundation

class CryptocurrencyPresentableMapper{
    func map(error: CryptocurrencyDomainError?) -> String {
        guard error == .tooManyRequests else {
            return "Something went wrong"
        }
        return "You have exceeded the limit. Try again later"
    }
}
