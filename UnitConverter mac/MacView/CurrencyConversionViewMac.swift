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
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        Text("From Currency")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("", selection: $viewModel.selectedFromCurrencyIndex) {
                            ForEach(0..<viewModel.availableCurrencies.count, id: \.self) { index in
                                Text("\(viewModel.availableCurrencies[index].symbol) (\(viewModel.availableCurrencies[index].name))")
                            }
                        }
                        .labelsHidden()
                        .frame(width: 250)
                    }
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("To Currency")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("", selection: $viewModel.selectedToCurrencyIndex) {
                            ForEach(0..<viewModel.availableCurrencies.count, id: \.self) { index in
                                Text("\(viewModel.availableCurrencies[index].symbol) (\(viewModel.availableCurrencies[index].name))")
                            }
                        }
                        .labelsHidden()
                        .frame(width: 250)
                    }
                }
                .padding()
            }
            
            Section {
                HStack {
                    TextField("Enter value", text: $viewModel.inputValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                    
                    Text(viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].symbol)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        if let pasteboardString = NSPasteboard.general.string(forType: .string) {
                            let filteredString = pasteboardString.filter { "0123456789.,".contains($0) }
                            viewModel.inputValue = filteredString
                            viewModel.convertCurrency()
                        }
                    }) {
                        Text("Paste")
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
            
            Section {
                HStack {
                    Text(viewModel.convertedValue)
                        .font(.title2)
                    Text(viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].symbol)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(viewModel.convertedValue, forType: .string)
                        withAnimation {
                            copiedToClipboard = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                copiedToClipboard = false
                            }
                        }
                    }) {
                        Text("Copy")
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
            
            Button(action: swapCurrencies) {
                HStack {
                    Spacer()
                    Image(systemName: "arrow.up.arrow.down")
                    Text("Swap")
                    Spacer()
                }
            }
            .buttonStyle(.bordered)
            .padding()
        }
        .formStyle(.grouped)
        .toolbar {
            ToolbarItem {
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                }
            }
            
            ToolbarItem {
                Button(action: {
                    viewModel.isInfoPresented = true
                }) {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $viewModel.isInfoPresented) {
            CategoryInfoViewMac(category: viewModel.category)
        }
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
            updateFavoriteStatus()
        }
        .onChange(of: viewModel.selectedFromCurrencyIndex) { updateFavoriteStatus() }
        .onChange(of: viewModel.selectedToCurrencyIndex) { updateFavoriteStatus() }
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
    
    private func swapCurrencies() {
        let tempIndex = viewModel.selectedFromCurrencyIndex
        viewModel.selectedFromCurrencyIndex = viewModel.selectedToCurrencyIndex
        viewModel.selectedToCurrencyIndex = tempIndex
        viewModel.convertCurrency()
    }
    
    private func toggleFavorite() {
        if isFavorite {
            if let favorite = favoritesViewModel.getFavorites().first(where: {
                $0.category == CurrencyUnitsCategory.currency.rawValue &&
                $0.fromUnit == viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].symbol &&
                $0.toUnit == viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].symbol
            }) {
                favoritesViewModel.removeFavorite(favorite)
            }
        } else {
            favoritesViewModel.addFavorite(
                category: CurrencyUnitsCategory.currency.rawValue,
                fromUnit: viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].symbol,
                toUnit: viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].symbol
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
        isFavorite = favoritesViewModel.isFavorite(
            category: CurrencyUnitsCategory.currency.rawValue,
            fromUnit: viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].symbol,
            toUnit: viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].symbol
        )
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return CurrencyConversionViewMac()
            .modelContainer(container)
            .frame(width: 600, height: 400)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
