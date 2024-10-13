//
//  CurrencyConverterView.swift  .swift
//  UnitConverter
//
//  Created by Burak Albayrak on 7.09.2024.
//

import SwiftUI

struct CurrencyConversionView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = CurrencyConversionViewModel()
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var copiedToClipboard: Bool = false
    @State private var isCopyButtonPressed: Bool = false
    @State private var isPasteButtonPressed: Bool = false
    @State private var isFavoriteButtonPressed: Bool = false
    @State private var addedToFavorites: Bool = false
    @State private var isFavorite: Bool = false

    var body: some View {
        Form {
            Section(LocalizedStringKey("Select Currencies")) {
                Picker(LocalizedStringKey("From Currency"), selection: $viewModel.selectedFromCurrencyIndex) {
                    ForEach(0 ..< viewModel.availableCurrencies.count, id: \.self) { index in
                        Text("\(viewModel.availableCurrencies[index].symbol) (\(viewModel.availableCurrencies[index].name))")
                    }
                }
                .id(viewModel.selectedFromCurrencyIndex)
                
                Picker(LocalizedStringKey("To Currency"), selection: $viewModel.selectedToCurrencyIndex) {
                    ForEach(0 ..< viewModel.availableCurrencies.count, id: \.self) { index in
                        Text("\(viewModel.availableCurrencies[index].symbol) (\(viewModel.availableCurrencies[index].name))")
                    }
                }
                .id(viewModel.selectedToCurrencyIndex)
            }
            
            Section("Value") {
                HStack {
                    Button(action: {
                        if !viewModel.inputValue.starts(with: "-") {
                            viewModel.inputValue = "-" + viewModel.inputValue
                        }
                    }) {
                        Text("-")
                            .padding(7)
                            .padding(.horizontal, 7)
                            .foregroundStyle(.cyan)
                            .background(.ultraThinMaterial)
                            .containerShape(.rect(cornerRadius: 10))
                            .opacity(isPasteButtonPressed ? 0.5 : 1.0)
                            .animation(.easeInOut(duration: 0.1), value: isPasteButtonPressed)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPasteButtonPressed = true }
                            .onEnded { _ in isPasteButtonPressed = false }
                    )
                    TextField(LocalizedStringKey("Enter value"), text: $viewModel.inputValue)
                        .keyboardType(.decimalPad)
                    
                        .onChange(of: viewModel.inputValue) { _, _ in
                            viewModel.convertCurrency()
                            viewModel.inputValue = viewModel.inputValue.replacingOccurrences(of: ",", with: ".")
                        }
                    if viewModel.selectedFromCurrencyIndex < viewModel.availableCurrencies.count {
                        Text(viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].symbol)
                    }
                    Spacer()
                    Button(action: {
                        if let pasteboardString = UIPasteboard.general.string {
                            viewModel.inputValue = pasteboardString
                        }
                    }) {
                        Text("paste")
                            .padding(9)
                            .padding(.horizontal)
                            .foregroundStyle(.cyan)
                            .background(.ultraThinMaterial)
                            .containerShape(.rect(cornerRadius: 10))
                            .opacity(isPasteButtonPressed ? 0.5 : 1.0)
                            .animation(.easeInOut(duration: 0.1), value: isPasteButtonPressed)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isPasteButtonPressed = true }
                            .onEnded { _ in isPasteButtonPressed = false }
                    )
                }
            }
            
            Section("Result") {
                HStack {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(LocalizedStringKey(errorMessage))
                            .foregroundColor(.red)
                    } else {
                        Text(viewModel.convertedValue)
                        Spacer()
                        Text(viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].symbol)
                    }
                    Button(action: {
                        UIPasteboard.general.string = viewModel.convertedValue
                        withAnimation(.easeIn(duration: 0.5)) {
                            copiedToClipboard = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeOut(duration: 2)) {
                                copiedToClipboard = false
                            }
                        }
                    }) {
                        Text("copy")
                            .padding(9)
                            .padding(.horizontal)
                            .foregroundStyle(.cyan)
                            .background(.ultraThinMaterial)
                            .containerShape(.rect(cornerRadius: 10))
                            .opacity(isCopyButtonPressed ? 0.5 : 1.0)
                            .animation(.easeInOut(duration: 0.1), value: isCopyButtonPressed)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in isCopyButtonPressed = true }
                            .onEnded { _ in isCopyButtonPressed = false }
                    )
                }
            }
            
            Section {
                Button(action: swapCurrencies) {
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.up.arrow.down")
                        Text(LocalizedStringKey("SwapCurrencies"))
                        Spacer()
                    }
                }
                .foregroundStyle(.cyan)
            }
        }
        .navigationTitle(LocalizedStringKey("Currency"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    UIApplication.shared.hideKeyboard()
                }, label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .font(.callout)
                        .foregroundColor(.cyan)
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .font(.title3)
                        .foregroundColor(.cyan)
                        .scaleEffect(isFavoriteButtonPressed ? 1.2 : 1.0)
                }
            }
            
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
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
            updateFavoriteStatus()
        }
        .onChange(of: viewModel.selectedFromCurrencyIndex) { _, _ in updateFavoriteStatus() }
        .onChange(of: viewModel.selectedToCurrencyIndex) { _, _ in updateFavoriteStatus() }
        .sheet(isPresented: $viewModel.isInfoPresented) {
            CategoryInfoView(category: viewModel.category)
        }
        .overlay {
            if copiedToClipboard {
                feedbackOverlay(message: LocalizedStringKey("Copied to Clipboard"))
            }
            if addedToFavorites {
                feedbackOverlay(message: LocalizedStringKey("Added to Favorites"))
            }
        }
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
        
        withAnimation(.spring()) {
            isFavorite.toggle()
        }
        isFavoriteButtonPressed = true
        
        if isFavorite {
            withAnimation(.easeIn(duration: 0.5)) {
                addedToFavorites = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeOut(duration: 2)) {
                    addedToFavorites = false
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isFavoriteButtonPressed = false
        }
    }
    
    private func feedbackOverlay(message: LocalizedStringKey) -> some View {
        Text(message)
            .font(.system(.body, design: .rounded, weight: .semibold))
            .foregroundStyle(.white)
            .padding()
            .background(Color.cyan.cornerRadius(20))
            .padding(.bottom)
            .shadow(radius: 5)
            .transition(.move(edge: .bottom))
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    private func updateFavoriteStatus() {
        guard viewModel.selectedFromCurrencyIndex < viewModel.availableCurrencies.count,
              viewModel.selectedToCurrencyIndex < viewModel.availableCurrencies.count else {
            isFavorite = false
            return
        }
        
        isFavorite = favoritesViewModel.isFavorite(
            category: CurrencyUnitsCategory.currency.rawValue,
            fromUnit: viewModel.availableCurrencies[viewModel.selectedFromCurrencyIndex].symbol,
            toUnit: viewModel.availableCurrencies[viewModel.selectedToCurrencyIndex].symbol
        )
    }
    
    private func swapCurrencies() {
        let tempIndex = viewModel.selectedFromCurrencyIndex
        viewModel.selectedFromCurrencyIndex = viewModel.selectedToCurrencyIndex
        viewModel.selectedToCurrencyIndex = tempIndex
        viewModel.convertCurrency() 
    }
}

#Preview {
    CurrencyConversionView()
        .environmentObject(CurrencyConversionViewModel())
}
