//
//  GlobalCryptoListFactory.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

class GlobalCryptoListFactory {
    static func create() -> GlobalCryptoListView {
        return  GlobalCryptoListView(viewModel: createViewModel(),
                                     createCryptoDetailView: CryptoDetailFactory())
    }
    
    private static func createViewModel() -> GlobalCryptoListViewModel {
        GlobalCryptoListViewModel(getGlobalCryptoList: createUseCase(),
                                  errorMapper: CryptocurrencyPresentableMapper())
    }
    
    private static func createUseCase() -> GetGlobalCryptoListType {
      GetGlobalCryptoList(repository: createRepository())
    }
    
    private static func createRepository() -> GlobalCryptoListRepositoryType {
        
        let apiDataSource = createDataSource()
        
        return CryptoCurrencyRepository(apiDatasourcePriceInfo: apiDataSource,
                                 apiDatasourceSymbol: apiDataSource,
                                 apiDatasourceCrypto: apiDataSource,
                                 errorMapper: CryptocurrencyDomainErrorMapper(),
                                 domainMapper: CryptocurrencyDomainMapper())
    }
    
    private static func createDataSource() -> APICryptoDataSource {
        let httpClient = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker(),
                                              errorResolver: URLSessionErrorResolver())
        return APICryptoDataSource(httpClient: httpClient)
    }
    
}
