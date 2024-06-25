//
//  GlobalCryptoListViewModel.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

class GlobalCryptoListViewModel: ObservableObject {
    
    private let getGlobalCryptoList: GetGlobalCryptoListType
    private let errorMapper: CryptocurrencyPresentableMapper
    @Published var cryptos: [CryptoListPresentableItem] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String? = nil
    
    init(getGlobalCryptoList: GetGlobalCryptoListType, errorMapper: CryptocurrencyPresentableMapper) {
        self.getGlobalCryptoList = getGlobalCryptoList
        self.errorMapper = errorMapper
    }
    
    func onAppear(){
        showLoadingSpinner = true
        Task {
            let result = await  getGlobalCryptoList.execute()
            
            guard case .success(let cryptos) = result else {
                handleError(error: result.failureValue as? CryptocurrencyDomainError)
              return
            }

           let cryptoPresentable = cryptos.map{CryptoListPresentableItem(domainModel: $0) }
            
            Task { @MainActor in
                showLoadingSpinner = false
                self.cryptos = cryptoPresentable
            }
           
        }
       
    }
    
    private func handleError(error: CryptocurrencyDomainError?) {
        
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage = errorMapper.map(error: error)
        }
    }
}
