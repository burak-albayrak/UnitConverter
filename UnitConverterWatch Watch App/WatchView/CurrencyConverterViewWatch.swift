//
//  CurrencyConverterViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI
import SwiftUI_Apple_Watch_Decimal_Pad

struct CurrencyConverterViewWatch: View {
    @StateObject private var viewModel = CurrencyConversionViewModel()
    @State private var showingFromCurrencyPicker = false
    @State private var showingToCurrencyPicker = false
    @State public var presentingModal: Bool

    var body: some View {
        List {
            Section("Currencies") {
                HStack {
                    Text("From:")
                    Spacer()
                    Button(currencyText(for: viewModel.selectedFromCurrencyIndex)) {
                        showingFromCurrencyPicker = true
                    }
                }
                HStack {
                    Text("To:")
                    Spacer()
                    Button(currencyText(for: viewModel.selectedToCurrencyIndex)) {
                        showingToCurrencyPicker = true
                    }
                }
            }
            
            Section("Value") {
                DigiTextView(placeholder: "Enter value", text: $viewModel.inputValue, presentingModal: false, style: .decimal)
                    .onChange(of: viewModel.inputValue) { _, newValue in
                        let filtered = newValue.filter { "-0123456789.,".contains($0) }
                        if filtered != newValue {
                            viewModel.inputValue = filtered
                        }
                        viewModel.convertCurrency()
                    }
                
                Button(action: toggleNegative) {
                    HStack {
                        Image(systemName: "plusminus")
                        Text("Make Negative/Positive")
                    }
                }
            }
            
            Section("Result") {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    Text(viewModel.convertedValue)
                }
            }
            
            Section {
                Button("Swap Currencies") {
                    swapCurrencies()
                }
                
                Button("Refresh Rates") {
                    viewModel.fetchExchangeRates()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Currency")
        .sheet(isPresented: $showingFromCurrencyPicker) {
            currencyPicker(selection: $viewModel.selectedFromCurrencyIndex)
        }
        .sheet(isPresented: $showingToCurrencyPicker) {
            currencyPicker(selection: $viewModel.selectedToCurrencyIndex)
        }
    }
    
    private func currencyText(for index: Int) -> String {
        guard index < viewModel.availableCurrencies.count else { return "" }
        let currency = viewModel.availableCurrencies[index]
        return "\(currency.symbol) (\(currency.name))"
    }
    
    private func currencyPicker(selection: Binding<Int>) -> some View {
        List {
            ForEach(0..<viewModel.availableCurrencies.count, id: \.self) { index in
                Button(currencyText(for: index)) {
                    selection.wrappedValue = index
                    showingFromCurrencyPicker = false
                    showingToCurrencyPicker = false
                    viewModel.convertCurrency()
                }
            }
        }
    }
    
    private func swapCurrencies() {
        let tempIndex = viewModel.selectedFromCurrencyIndex
        viewModel.selectedFromCurrencyIndex = viewModel.selectedToCurrencyIndex
        viewModel.selectedToCurrencyIndex = tempIndex
        viewModel.convertCurrency()
    }
    
    private func toggleNegative() {
        if viewModel.inputValue.isEmpty {
            return
        }
        
        if viewModel.inputValue.hasPrefix("-") {
            viewModel.inputValue.removeFirst()
        } else {
            viewModel.inputValue = "-" + viewModel.inputValue
        }
        
        if viewModel.inputValue.last == "." || viewModel.inputValue.last == "," {
            viewModel.inputValue.removeLast()
        }
        
        viewModel.convertCurrency()
    }
}

struct AllConvertersView: View {
    var body: some View {
        List(AllConvertersCategory.allCases) { category in
            NavigationLink(destination: AllConvertersMenuWatch(category: category)) {
                Label(category.localizedName, systemImage: category.icon)
            }
        }
        .navigationTitle("All Converters")
    }
}



#Preview {
    CurrencyConverterViewWatch(presentingModal: false)
}
