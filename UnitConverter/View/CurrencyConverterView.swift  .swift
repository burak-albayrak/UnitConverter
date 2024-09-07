//
//  CurrencyConverterView.swift  .swift
//  UnitConverter
//
//  Created by Burak Albayrak on 7.09.2024.
//

import SwiftUI

struct CurrencyConverterView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()
    
    var body: some View {
        Form {
            Section("Select Currencies") {
                Picker("From Currency", selection: $viewModel.selectedFromCurrencyIndex) {
                    ForEach(0 ..< viewModel.category.availableUnits.count, id: \.self) { index in
                        Text("\(viewModel.category.availableUnits[index].symbol) (\(viewModel.category.availableUnitNames[index]))")
                    }
                }
                .onChange(of: viewModel.selectedFromCurrencyIndex) { _, _ in
                    viewModel.convertCurrency()
                }
                
                Picker("To Currency", selection: $viewModel.selectedToCurrencyIndex) {
                    ForEach(0 ..< viewModel.category.availableUnits.count, id: \.self) { index in
                        Text("\(viewModel.category.availableUnits[index].symbol) (\(viewModel.category.availableUnitNames[index]))")
                    }
                }
                .onChange(of: viewModel.selectedToCurrencyIndex) { _, _ in
                    viewModel.convertCurrency()
                }
            }
            
            Section("Value") {
                TextField("Enter value to convert", text: $viewModel.inputValue)
                    .keyboardType(.decimalPad)
                    .onChange(of: viewModel.inputValue) { _, _ in
                        viewModel.convertCurrency()
                    }
            }
            
            Section("Result") {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    Text("\(viewModel.convertedValue) \(viewModel.category.availableUnits[viewModel.selectedToCurrencyIndex].symbol)")
                }
            }
        }
        .navigationTitle("Currency Converter")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.fetchExchangeRates()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.isInfoPresented = true
                }) {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $viewModel.isInfoPresented) {
            CategoryInfoView(category: viewModel.category)
        }
    }
}
