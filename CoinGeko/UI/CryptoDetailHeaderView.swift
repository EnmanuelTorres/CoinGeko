//
//  CryptoDetailHeaderView.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import SwiftUI

struct CryptoDetailHeaderView: View {
    private let cryptocurrency: CryptoListPresentableItem
    
    init(cryptocurrency: CryptoListPresentableItem) {
        self.cryptocurrency = cryptocurrency
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(cryptocurrency.name).font(.title)
                    Text(cryptocurrency.symbol).font(.title)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(cryptocurrency.price).font(.title)
                    
                    Text((cryptocurrency.isPriceChangePositive ? "+" : "") + cryptocurrency.price24h )
                        .foregroundStyle(cryptocurrency.isPriceChangePositive ? .green : .red)
                        .font(.title)
                }
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
            
            HStack{
                Text("Cap. de mercado").font(.headline)
                Spacer()
                Text(cryptocurrency.marketCap).font(.headline)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            HStack{
                Text("Volumen en 24 h:").font(.headline)
                Spacer()
                Text(cryptocurrency.volume24h).font(.headline)
            }
            
        }
    }
}

