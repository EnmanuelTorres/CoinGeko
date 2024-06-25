//
//  CryptocurrencyPriceInfoType.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 9/04/24.
//

import Foundation

protocol  CryptocurrencyPriceInfoRepositoryType {
    func getPriceInfo(Id: String) async -> Result<CryptocurrencyPriceInfo, CryptocurrencyDomainError>

}
