//
//  ApiDatasourceType.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

protocol ApiDatasourcePriceInfoType {
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String : CryptocurrencyPriceInfoDTO], HTTPClientError>
}


protocol ApiDatasourceSymbolType {
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError>

}


protocol ApiDatasourceCryptoType {
    func getCryptoLis() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
}
