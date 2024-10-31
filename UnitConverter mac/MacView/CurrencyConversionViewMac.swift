//
//  CurrencyConversionViewMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI

struct CurrencyConversionViewMac: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = CurrencyConversionViewModel()
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var copiedToClipboard: Bool = false
    @State private var addedToFavorites: Bool = false
    @State private var isFavorite: Bool = false
    
    var body: some View {
        Form {
            Text("Currency")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, -5)
                .foregroundColor(.accentColor)
            
            Section(LocalizedStringKey("Select Units")) {
                if viewModel.availableCurrencies.isEmpty {
                    ProgressView("Loading currencies...")
                        .frame(maxWidth: .infinity)
                } else {
                    Picker(LocalizedStringKey("From Currency"), selection: $viewModel.selectedFromCurrencyIndex) {
                        ForEach(0..<viewModel.availableCurrencies.count, id: \.self) { index in
                            Text("\(viewModel.availableCurrencies[index].symbol) (\(viewModel.availableCurrencies[index].name))")
                        }
                    }
                    .id(viewModel.selectedFromCurrencyIndex)
                    
                    HStack {
                        Spacer()
                        Button(action: swapCurrenciesAndValues) {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.title2)
                        }
                        .buttonStyle(.borderless)
                        Spacer()
                    }
                    
                    Picker(LocalizedStringKey("To Currency"), selection: $viewModel.selectedToCurrencyIndex) {
                        ForEach(0..<viewModel.availableCurrencies.count, id: \.self) { index in
                            Text("\(viewModel.availableCurrencies[index].symbol) (\(viewModel.availableCurrencies[index].name))")
                        }
                    }
                    .id(viewModel.selectedToCurrencyIndex)
                }
            }
            
            if !viewModel.availableCurrencies.isEmpty {
                Section(LocalizedStringKey("Value")) {
                    HStack {
                        CustomTextFieldMac(text: $viewModel.inputValue, placeholder: "Enter value")
                            .frame(width: 200)
                        
                        if viewModel.selectedFromCurrencyIndex < viewModel.availableCurrencies.count {
                            Text(viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].symbol)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            if let pasteboardString = NSPasteboard.general.string(forType: .string) {
                                let filteredString = pasteboardString.filter { char in
                                    let decimalSeparator = Locale.current.decimalSeparator ?? "."
                                    return "0123456789-\(decimalSeparator)".contains(char)
                                }
                                viewModel.inputValue = filteredString
                            }
                        }) {
                            Text("Paste")
                        }
                        .buttonStyle(TransparentButtonStyle())
                    }
                }
                
                Section(LocalizedStringKey("Result")) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                        } else if let errorMessage = viewModel.errorMessage {
                            Text(LocalizedStringKey(errorMessage))
                                .foregroundColor(.red)
                            Spacer()
                            Button(action: {
                                viewModel.fetchExchangeRates()
                            }) {
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(.accentColor)
                            }
                        } else {
                            Text(viewModel.convertedValue)
                                .font(.title2)
                            
                            if viewModel.selectedToCurrencyIndex < viewModel.availableCurrencies.count {
                                Text(viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].symbol)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                NSPasteboard.general.clearContents()
                                NSPasteboard.general.setString(viewModel.convertedValue, forType: .string)
                                withAnimation {
                                    copiedToClipboard = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            copiedToClipboard = false
                                        }
                                    }
                                }
                            }) {
                                Text("Copy")
                            }
                            .buttonStyle(TransparentButtonStyle())
                        }
                    }
                }
            }
        }
        .formStyle(.grouped)
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Spacer()
                Button(action: {
                    viewModel.fetchExchangeRates()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.accentColor)
                }
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(.accentColor)
                }
                Button(action: {
                    viewModel.isInfoPresented = true
                }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.accentColor)
                }
            }
        }
        .sheet(isPresented: $viewModel.isInfoPresented) {
            CategoryInfoViewMac(category: viewModel.category)
        }
        .task {
            if viewModel.availableCurrencies.isEmpty {
                viewModel.fetchExchangeRates()
            }
            favoritesViewModel.setModelContext(modelContext)
            updateFavoriteStatus()
        }
        .onChange(of: viewModel.selectedFromCurrencyIndex) { updateFavoriteStatus() }
        .onChange(of: viewModel.selectedToCurrencyIndex) { updateFavoriteStatus() }
        .onChange(of: viewModel.inputValue) { _,_ in
            viewModel.convertCurrency()
        }
        .overlay {
            if copiedToClipboard {
                feedbackOverlay(message: "Copied to Clipboard")
            }
            if addedToFavorites {
                feedbackOverlay(message: "Added to Favorites")
            }
        }
    }
    
    private func feedbackOverlay(message: String) -> some View {
        Text(message)
            .font(.system(.body, design: .rounded, weight: .semibold))
            .foregroundStyle(.white)
            .padding()
            .background(Color.accentColor.cornerRadius(10))
            .shadow(radius: 5)
            .transition(.move(edge: .bottom))
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom)
    }
    
    private func swapCurrenciesAndValues() {
        let tempIndex = viewModel.selectedFromCurrencyIndex
        viewModel.selectedFromCurrencyIndex = viewModel.selectedToCurrencyIndex
        viewModel.selectedToCurrencyIndex = tempIndex
        viewModel.convertCurrency()
    }
    
    private func toggleFavorite() {
        if isFavorite {
            if let favorite = favoritesViewModel.getFavorites().first(where: {
                $0.category == viewModel.category.rawValue &&
                $0.fromUnit == viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].name &&
                $0.toUnit == viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].name
            }) {
                favoritesViewModel.removeFavorite(favorite)
            }
        } else {
            favoritesViewModel.addFavorite(
                category: viewModel.category.rawValue,
                fromUnit: viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].name,
                toUnit: viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].name
            )
        }
        
        withAnimation {
            isFavorite.toggle()
            if isFavorite {
                addedToFavorites = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        addedToFavorites = false
                    }
                }
            }
        }
    }
    
    private func updateFavoriteStatus() {
        guard !viewModel.availableCurrencies.isEmpty else { return }
        
        isFavorite = favoritesViewModel.isFavorite(
            category: viewModel.category.rawValue,
            fromUnit: viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].symbol,
            toUnit: viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].symbol
        )
    }
}
