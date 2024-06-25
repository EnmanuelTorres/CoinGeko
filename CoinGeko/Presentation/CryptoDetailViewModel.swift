//
//  CryptoDetailViewModel.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import Foundation

class CryptoDetailViewModel : ObservableObject {
    
    @Published var dataPoints: [ChartDataPoint] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String? = nil
    
    private let getPriceHistory: GetPriceHistory
    private let errorMapper: CryptocurrencyPresentableMapper
    let cryptocurrency: CryptoListPresentableItem
    
    init(getPriceHistory: GetPriceHistory,
         errorMapper: CryptocurrencyPresentableMapper,
         cryptocurrency: CryptoListPresentableItem) {
        self.getPriceHistory = getPriceHistory
        self.errorMapper = errorMapper
        self.cryptocurrency = cryptocurrency
    }
    
    func getPriceHistory(option: DaysOptions) {
        showLoadingSpinner = true
        showErrorMessage = nil
        Task {
            let result = await getPriceHistory.execute(id: cryptocurrency.id, days: option.toInt())
            
            guard case .success(let priceHistory) = result else {
                handleError(error: result.failureValue as? CryptocurrencyDomainError)
                return
            }

            let dataPoints = priceHistory.prices.map{ ChartDataPoint(date: $0.date, price: $0.price) }
            
            Task { @MainActor in
                showLoadingSpinner = false
                self.dataPoints = dataPoints
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
