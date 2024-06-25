//
//  DaysOptions.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 6/04/24.
//

import Foundation

enum DaysOptions: String, CaseIterable, Equatable {
    case moth = "30d"
    case Ninety = "90d"
    case OneHundredEighty = "180d"
    case year = "1a"
    
    func toInt() -> Int {
        switch self {
        case .moth:
           return 30
        case .Ninety:
            return 90
        case .OneHundredEighty:
           return  180
        case .year:
           return 365
        }
    }
}
