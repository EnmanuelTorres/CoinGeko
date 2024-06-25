//
//  CryptoListView.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 8/04/24.
//

import SwiftUI

struct CryptoListView: View {
    
    @ObservedObject private var viewModel: CryptoListViewModel
    private let createCryptoDetailView : CreateCryptoDetailView
    @State private var searchCrypto: String = ""
    
    init(viewModel: CryptoListViewModel, createCryptoDetailView : CreateCryptoDetailView) {
        self.viewModel = viewModel
        self.createCryptoDetailView = createCryptoDetailView
    }
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                ProgressView().progressViewStyle(.circular)
            } else {
                if viewModel.showErrorMessage == nil {
                    NavigationStack {
                        List {
                            ForEach(viewModel.cryptos, id: \.id) { crypto in
                               
                                Button {
                                    viewModel.getCrypto(crypto)
                                } label: {
                                    CryptoListBasicInfoItemView(item: crypto)
                                }.buttonStyle(.plain)
                            }
                        }.navigationDestination(item: $viewModel.cryptoDetail) { crypto in
                            createCryptoDetailView.create(cryptocurrency: crypto)
                        }
                    }
                    .searchable(text: $searchCrypto)
                    .onChange(of: searchCrypto) { oldValue, newValue in
                        viewModel.search(crypto: newValue)
                    }
                }else {
                    Text(viewModel.showErrorMessage!)
                }
                
            }
           
        }
        .onAppear{
            viewModel.onAppear()
        }
    }
}
