//
//  CurrencyConverterViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI
import SwiftUI_Apple_Watch_Decimal_Pad

struct CurrencyConverterViewWatch: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: CurrencyConversionViewModel
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var showingFromCurrencyPicker = false
    @State private var showingToCurrencyPicker = false
    @State public var presentingModal: Bool
    @State private var showingInfoView = false
    @State private var isFavorite: Bool = false
    @State private var addedToFavorites: Bool = false
    let favorite: FavoriteConversion?

    init(presentingModal: Bool, favorite: FavoriteConversion? = nil) {
        self._viewModel = StateObject(wrappedValue: CurrencyConversionViewModel())
        self._presentingModal = State(initialValue: presentingModal)
        self.favorite = favorite
    }

    var body: some View {
        List {
            Section(LocalizedStringKey("Currencies")) {
                HStack {
                    Text(LocalizedStringKey("From:"))
                    Spacer()
                    Button(currencyText(for: viewModel.selectedFromCurrencyIndex)) {
                        showingFromCurrencyPicker = true
                    }
                }
                HStack {
                    Text(LocalizedStringKey("To:"))
                    Spacer()
                    Button(currencyText(for: viewModel.selectedToCurrencyIndex)) {
                        showingToCurrencyPicker = true
                    }
                }
            }
            
            Section(LocalizedStringKey("Value")) {
                DigiTextView(placeholder: String(localized: "Enter value"), text: $viewModel.inputValue, presentingModal: false, style: .decimal)
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
                        Text(LocalizedStringKey("Make Negative/Positive"))
                    }
                }
            }
            
            Section(LocalizedStringKey("Result")) {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(LocalizedStringKey(errorMessage))
                        .foregroundColor(.red)
                } else {
                    Text(viewModel.convertedValue)
                }
            }
            
            Section {
                Button(LocalizedStringKey("Swap Currencies")) {
                    swapCurrencies()
                }
                
                Button(LocalizedStringKey("Refresh Rates")) {
                    viewModel.fetchExchangeRates()
                }
                
                Button(action: toggleFavorite) {
                    HStack {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                            .foregroundColor(isFavorite ? .indigo : .primary)
                        Text(LocalizedStringKey(isFavorite ? "Remove from Favorites" : "Add to Favorites"))
                            .foregroundColor(isFavorite ? .indigo : .primary)
                    }
                }
                
                Button(action: { showingInfoView = true }) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text(LocalizedStringKey("Currency Info"))
                    }
                }
                .foregroundColor(.indigo)
            }
        }
        .sheet(isPresented: $showingFromCurrencyPicker) {
            currencyPicker(selection: $viewModel.selectedFromCurrencyIndex)
        }
        .sheet(isPresented: $showingToCurrencyPicker) {
            currencyPicker(selection: $viewModel.selectedToCurrencyIndex)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(LocalizedStringKey("Currency"))
        .sheet(isPresented: $showingInfoView) {
            CategoryInfoViewWatch(category: CurrencyUnitsCategory.currency)
        }
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
            updateFavoriteStatus()
        }
        .task {
            await setInitialCurrencies()
        }
        .onChange(of: viewModel.selectedFromCurrencyIndex) { _, _ in updateFavoriteStatus() }
        .onChange(of: viewModel.selectedToCurrencyIndex) { _, _ in updateFavoriteStatus() }
        .overlay {
            if addedToFavorites {
                Text(LocalizedStringKey("Added to Favorites"))
                    .font(.caption)
                    .padding()
                    .background(Color.indigo.opacity(0.8))
                    .cornerRadius(10)
                    .transition(.move(edge: .top))
                    .animation(.easeInOut, value: addedToFavorites)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                addedToFavorites = false
                            }
                        }
                    }
            }
        }
    }
    
    private func setInitialCurrencies() async {
        await MainActor.run {
            if let favorite = favorite,
               let fromIndex = viewModel.availableCurrencies.firstIndex(where: { $0.symbol == favorite.fromUnit }),
               let toIndex = viewModel.availableCurrencies.firstIndex(where: { $0.symbol == favorite.toUnit }) {
                viewModel.selectedFromCurrencyIndex = fromIndex
                viewModel.selectedToCurrencyIndex = toIndex
                viewModel.convertCurrency()
            }
        }
    }
    
    private func setFromFavorite() {
        if let favorite = favorite {
            if let fromIndex = viewModel.availableCurrencies.firstIndex(where: { $0.symbol == favorite.fromUnit }),
               let toIndex = viewModel.availableCurrencies.firstIndex(where: { $0.symbol == favorite.toUnit }) {
                viewModel.selectedFromCurrencyIndex = fromIndex
                viewModel.selectedToCurrencyIndex = toIndex
                viewModel.convertCurrency()
            }
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
            withAnimation {
                addedToFavorites = true
            }
        }
        
        withAnimation {
            isFavorite.toggle()
        }
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
}

struct AllConvertersView: View {
    var body: some View {
        List(AllConvertersCategory.allCases) { category in
            NavigationLink(destination: AllConvertersMenuWatch(category: category)) {
                Label(category.localizedName, systemImage: category.icon)
            }
        }
        .navigationTitle(String(localized: String.LocalizationValue("All Converters")))
    }
}

#Preview {
    CurrencyConverterViewWatch(presentingModal: false)
}
