//
//  CryptoListFactory.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import Foundation


class CryptoListFactory {
    static func create() -> CryptoListView {
        CryptoListView(viewModel: createViewModel(),
                       createCryptoDetailView: CryptoDetailFactory())
    }
    
    private static func createViewModel() -> CryptoListViewModel {
        CryptoListViewModel(errorMapper: CryptocurrencyPresentableMapper(),
                            getCryptoListType: createGetCryptoListUseCase(),
                            searchCryptoList:  createSearchCryptoListUseCase(),
                            cryptoListItemAdapter: createCryptoListItemAdapter())
    }
    
    private static func createCryptoListItemAdapter() -> CryptoListItemAdapterType {
        CryptoListItemAdapter(getPriceInfo: createGetPriceInfoUseCase())
    }
    
    
    private static func createGetCryptoListUseCase() -> GetCryptoListType {
        GetCryptoList(repository: createGetCryptoListRepository())
    }
    
    private static func createSearchCryptoListUseCase() -> SearchCryptoListType {
        SearchCryptoList(repository: createGetCryptoListRepository())
    }
    
    private static func createGetPriceInfoUseCase() -> getPriceInfoType {
        getPriceInfo(repository: createPriceInfoRepository())
    }
    
    private static func createGetCryptoListRepository() -> CryptocurrencyBasicInfoRepository {
        CryptocurrencyBasicInfoRepository(apiDatasource: createAPIDataSource(),
                                          errorMapper: CryptocurrencyDomainErrorMapper(),
                                          cacheDatasource: createCacheDataSource())
    }
    
    private static func createCacheDataSource() -> CacheCryptocurrencyBasicInfoDataSourceType {
        StrategyCacheCryptocurrencyBasicInfo(temporalCache: InMemoryCacheCryptocurrencyBasicInfoDataSource.shared,
                                             persistenceCache: createPersistenceCacheDataSource())
    }
    
    private static func createPersistenceCacheDataSource() -> CacheCryptocurrencyBasicInfoDataSourceType {
        SwiftDataCacheBasicInfoDataSource(container: SwiftDataContainer.shared)
    }
    
    
    private static func createPriceInfoRepository() -> CryptocurrencyPriceInfoRepositoryType {
        CryptocurrencyPriceRepository(apiDataSource: createAPIDataSource(),
                                      domainMapper: CryptocurrencyPriceHistoryDomainMapper(),
                                      errorMapper: CryptocurrencyDomainErrorMapper())
    }
    
    private static func createAPIDataSource() -> APICryptocurrencyBasicInfoDataSourceType {
        APICryptoDataSource(httpClient:  createAPIDataSource())
    }
    
    private static func createAPIDataSource() -> ApiPriceDataSourceType {
        APIPriceDataSource(httpClient: createAPIDataSource())
    }
    
    private static func createAPIDataSource() -> HTTPClient {
        URLSessionHTTPClient(requestMaker: URLSessionRequestMaker(),
                             errorResolver: URLSessionErrorResolver())
    }
}
