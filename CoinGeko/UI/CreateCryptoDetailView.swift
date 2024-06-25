//
//  CreateCryptoDetailView.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 6/04/24.
//

import Foundation

protocol CreateCryptoDetailView {
    func create(cryptocurrency: CryptoListPresentableItem) -> CryptoDetailView
}
