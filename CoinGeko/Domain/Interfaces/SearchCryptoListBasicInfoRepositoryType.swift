//
//  SearchCryptoListType.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import Foundation

protocol SearchCryptoListBasicInfoRepositoryType{
    func search(crypto: String) async -> Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError>
}
