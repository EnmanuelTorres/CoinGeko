//
//  SwiftDataContainer.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 9/04/24.
//

import Foundation
import SwiftData

class SwiftDataContainer: SwiftSDataContainerType {
    
    static let shared = SwiftDataContainer()
    private let container: ModelContainer
    private let context: ModelContext
    
    private init(){
        let scheme = Schema([CryptocurrencyBasicInfoData.self])
        container = try! ModelContainer(for: scheme,
                                   configurations: [])
        context = ModelContext(container)
    }
    
    func fetchCryptos() -> [CryptocurrencyBasicInfoData] {
        let descriptor = FetchDescriptor<CryptocurrencyBasicInfoData>()
        
        guard let cryptos = try?  context.fetch(descriptor) else {
            return []
        }
        return cryptos
    }
    
    func insert(_ cryptoList: [CryptocurrencyBasicInfoData]) async {
        cryptoList.forEach { crypto in
            context.insert(crypto)
        }
        
         try? context.save()
    }
}
