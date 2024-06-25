//
//  CryptoDetailView.swift
//  CoinGeko
//
//  Created by ENMANUEL TORRES on 5/04/24.
//

import SwiftUI
import Charts

struct CryptoDetailView: View {
    
   @ObservedObject private var viewModel: CryptoDetailViewModel
   @State private var selectedItem: DaysOptions = .moth
    
    init(viewModel: CryptoDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                CryptoDetailHeaderView(cryptocurrency: viewModel.cryptocurrency)
                
                Chart(viewModel.dataPoints) {
                    LineMark(x: .value("Fecha", $0.date),
                             y: .value("Precio", $0.price))
                }
                
                Picker("", selection: $selectedItem) {
                    ForEach(DaysOptions.allCases, id: \.self) { option in
                        Text(option.rawValue)
                    }
                }
                .onChange(of: selectedItem) { oldValue, newValue in
                    viewModel.getPriceHistory(option: newValue)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .onAppear{
                viewModel.getPriceHistory(option: selectedItem)
            }
            
            if viewModel.showLoadingSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if let errorMessage = viewModel.showErrorMessage {
                VStack {
                    Text(errorMessage)
                    Button {
                        viewModel.getPriceHistory(option: selectedItem)
                    } label: {
                        Text("Try again")
                    }

                }
            }
        }
    }
    
}




