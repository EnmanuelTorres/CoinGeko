//
//  CryptoDetailFactory.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 6/04/24.
//

import Foundation

class CryptoDetailFactory : CreateCryptoDetailView{
    func create(cryptocurrency: CryptoListPresentableItem) -> CryptoDetailView {
        CryptoDetailView(viewModel: createViewModel(cryptocurrency: cryptocurrency))
    }
    
    private func createViewModel(cryptocurrency: CryptoListPresentableItem) -> CryptoDetailViewModel {
        CryptoDetailViewModel(getPriceHistory: createUseCase(),
                              errorMapper: CryptocurrencyPresentableMapper(),
                              cryptocurrency: cryptocurrency)
    }
    
    private func createUseCase() -> GetPriceHistory {
        GetPriceHistory(repository: createRepository())
    }
    
    private func createRepository() -> CryptocurrencyPriceHistoryRepositoryType {
        CryptocurrencyPriceRepository(apiDataSource: createDataSource(),
                                      domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
                                      errorMapper: CryptocurrencyDomainErrorMapper())
    }
    
    private func createDataSource() -> ApiPriceDataSourceType {
        APIPriceDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> HTTPClient {
        URLSessionHTTPClient(requestMaker: URLSessionRequestMaker(),
                             errorResolver: URLSessionErrorResolver())
    }
    
}
