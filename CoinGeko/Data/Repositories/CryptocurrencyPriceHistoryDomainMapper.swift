//
//  CryptocurrencyPriceHistoryDomainMapper.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import Foundation
class CryptocurrencyPriceHistoryDomainMapper {
    func map(priceHistoryDTO: CryptocurrencyPriceHistoryDTO) -> CryptocurrencyPriceHistory {
        
        
        let dataPoints: [CryptocurrencyPriceHistory.DataPoint] = priceHistoryDTO.prices.compactMap{ dataPoint in
            
            guard dataPoint.count >= 2,
                let date = timestampToDate(dataPoint[0]) else {return nil}
            
          return   CryptocurrencyPriceHistory.DataPoint(price: dataPoint[1], date: date)
        }
        return CryptocurrencyPriceHistory(prices: dataPoints)
    }
    
    private func timestampToDate(_ timestamp: Double) -> Date?{
       let calendar = Calendar.current
     let components = calendar.dateComponents([.day, .month, .year], from: Date(timeIntervalSince1970: timestamp ))
        
        guard let date = calendar.date(from: components) else {return nil}
        return date
    }
}
