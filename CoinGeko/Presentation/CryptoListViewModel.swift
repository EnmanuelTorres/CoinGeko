//
//  CryptoListViewModel.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import Foundation

class CryptoListViewModel: ObservableObject {
    private let getCryptoListType: GetCryptoListType
    private let searchCryptoList:  SearchCryptoListType
    private let errorMapper: CryptocurrencyPresentableMapper
    private let cryptoListItemAdapter: CryptoListItemAdapterType
    @Published var cryptos: [CryptoListBasicInfoPresentableItem] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String? = nil
    @Published var cryptoDetail: CryptoListPresentableItem?

    init(errorMapper: CryptocurrencyPresentableMapper,
         getCryptoListType: GetCryptoListType,
         searchCryptoList:  SearchCryptoListType,
         cryptoListItemAdapter: CryptoListItemAdapterType) {
        self.errorMapper = errorMapper
        self.getCryptoListType = getCryptoListType
        self.searchCryptoList = searchCryptoList
        self.cryptoListItemAdapter = cryptoListItemAdapter
       
    }
    
    func onAppear(){
        showLoadingSpinner = true
        Task {
            let result = await  getCryptoListType.execute()
            handleResult(result)
        }
          
    }
    
    func search(crypto: String) {
        Task {
            let result = await  searchCryptoList.execute(crypto: crypto)
            handleResult(result)
        }
    }
    
    func getCrypto(_ crypto: CryptoListBasicInfoPresentableItem ) {
        Task {
            let result = await cryptoListItemAdapter.adapt(crypto: crypto)
            Task {@MainActor in
                cryptoDetail = result
            }
        }
       
    }
    
    private func handleResult(_ result: Result<[CryptocurrencyBasicInfo], CryptocurrencyDomainError>) {
        
        guard case .success(let cryptos) = result else {
            handleError(error: result.failureValue as? CryptocurrencyDomainError)
          return
        }

        let cryptoPresentable = cryptos.map{CryptoListBasicInfoPresentableItem(id: $0.id,
                                                                               name: $0.name,
                                                                               symbol: $0.symbol) }
        
        Task { @MainActor in
            showLoadingSpinner = false
            self.cryptos = cryptoPresentable
        }
       
    }
    
    private func handleError(error: CryptocurrencyDomainError?) {
        
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
}

