//
//  Foundation+Extensions.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import Foundation

extension Result {
    var failureValue: Error? {
        switch self {
        case .failure(let error):
            return error
            
        case .success:
            return nil
        }
    }
}

extension Double {
    func toCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        
        guard let formattedAmount = formatter.string(from: NSNumber(floatLiteral: self)) else {
            return nil
        }
        let currencyCode = "US$"
        
        return "\(formattedAmount.replacingOccurrences(of: currencyCode, with: ""))\(currencyCode)"
    }
}
