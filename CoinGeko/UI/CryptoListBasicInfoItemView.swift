//
//  CryptoListBasicInfoItemView.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import SwiftUI

struct CryptoListBasicInfoItemView: View {
    let item : CryptoListBasicInfoPresentableItem
    
    var body: some View {
        VStack(){
            HStack {
                Text(item.name)
                    .font(.title3)
                    .lineLimit(1)
                
                Spacer()
                
                Text(item.symbol)
                    .font(.headline)
            }.padding()
           
        }
    }
}

#Preview {
    CryptoListBasicInfoItemView(item: CryptoListBasicInfoPresentableItem(id: "", name: "Bitcoin", symbol: "BTC"))
}
