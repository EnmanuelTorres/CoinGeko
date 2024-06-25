//
//  CryptoListItemView.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 4/04/24.
//

import SwiftUI

struct CryptoListItemView: View {
    
    let item : CryptoListPresentableItem
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text(item.name)
                        .font(.title3)
                        .lineLimit(1)
                    
                    Text(item.symbol)
                        .font(.headline)
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(item.price)
                        .font(.title3)
                        .lineLimit(1)
                    
                    Text((item.isPriceChangePositive ? "+" : "") + item.price24h)
                        .font(.headline)
                        .foregroundStyle(item.isPriceChangePositive ? .green : .red)
                }
            }
            
            HStack {
                VStack(alignment: .leading){
                    Text("Market cap:")
                        .font(.system(size: 10))
                    
                    Text("24 h: ")
                        .font(.system(size: 10))
                }
                
                Spacer()
                
                VStack(alignment: .leading){
                    Text(item.marketCap)
                        .font(.system(size: 10))
                    
                    Text(item.volume24h)
                        .font(.system(size: 10))
                }
            }
        }
    }
}

#Preview {
    CryptoListItemView(item: item)
}

let domainModel = Cryptocurrency(id: "bct",
                                 name: "Bitcoin",
                                 symbol: "btc",
                                 price: 240000.4388,
                                 price24h: 1.2,
                                 volume24h: 340000000,
                                 marketCap: 13400340000000)
let item = CryptoListPresentableItem(domainModel: domainModel)
