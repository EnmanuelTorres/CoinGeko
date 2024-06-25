//
//  CoinGekoApp.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import SwiftUI

@main
struct CoinGekoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(globalCryptoList: GlobalCryptoListFactory.create(),
                        cryptoListView: CryptoListFactory.create())
        }
    }
}
