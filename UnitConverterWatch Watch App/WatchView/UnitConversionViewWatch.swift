//
//  UnitConversionViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI
import SwiftUI_Apple_Watch_Decimal_Pad

struct UnitConversionViewWatch<T: UnitCategory>: View {
        @Environment(\.dismiss) private var dismiss
        @Environment(\.modelContext) private var modelContext
        @StateObject var viewModel: UnitConversionViewModel<T>
        @StateObject private var favoritesViewModel = FavoritesViewModel()
        @State private var showingFromUnitPicker = false
        @State private var showingToUnitPicker = false
        @State private var isSelectingFromUnit = true
        @State private var isFavorite = false
        @State private var showingFavoriteMessage = false
        @State private var showingInfoView = false

        var favorite: FavoriteConversion?
    
    init(viewModel: UnitConversionViewModel<T>, favorite: FavoriteConversion? = nil) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.favorite = favorite
        
        if let favorite = favorite {
            let fromUnitIndex = viewModel.availableUnits.firstIndex { $0.name == favorite.fromUnit } ?? 0
            let toUnitIndex = viewModel.availableUnits.firstIndex { $0.name == favorite.toUnit } ?? 1
            viewModel.selectedFirstUnitIndex = fromUnitIndex
            viewModel.selectedSecondUnitIndex = toUnitIndex
        }
    }
        
        var body: some View {
            List {
                Section {
                    HStack {
                        Text("From:")
                        Spacer()
                        Button(unitText(for: viewModel.selectedFirstUnitIndex)) {
                            showingFromUnitPicker = true
                        }
                    }
                    HStack {
                        Text("To:")
                        Spacer()
                        Button(unitText(for: viewModel.selectedSecondUnitIndex)) {
                            showingToUnitPicker = true
                        }
                    }
                }
                
                Section("Value") {
                    DigiTextView(placeholder: "Enter value", text: $viewModel.firstUnitInputValue, presentingModal: false, style: .decimal)
                    
                    Button(action: toggleNegative) {
                        HStack {
                            Image(systemName: "plus.slash.minus")
                            Text("Make Negative/Positive")
                        }
                    }
                    
                    Button(action: addExponent) {
                        HStack {
                            Text("Add Exponent (e)")
                        }
                    }
                }
                
                Section("Result") {
                    Text(viewModel.convertUnits(value: viewModel.firstUnitInputValue))
                }
                
                Button("Swap") {
                    swapUnitsAndValues()
                }
                
                Button(action: toggleFavorite) {
                    HStack {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                            .foregroundColor(isFavorite ? .indigo : .primary)
                        Text(isFavorite ? "Remove from Favorites" : "Add to Favorites")
                            .foregroundColor(isFavorite ? .indigo : .primary)
                    }
                }
                
                Button(action: { showingInfoView = true }) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("Category Info")
                    }
                }
                .foregroundColor(.indigo)
            }
            .sheet(isPresented: $showingFromUnitPicker) {
                unitPicker(selection: $viewModel.selectedFirstUnitIndex)
            }
            .sheet(isPresented: $showingToUnitPicker) {
                unitPicker(selection: $viewModel.selectedSecondUnitIndex)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.category.localizedName)
            .sheet(isPresented: $showingInfoView) {
                CategoryInfoViewWatch(category: viewModel.category)
            }
            .onAppear {
                favoritesViewModel.setModelContext(modelContext)
                updateFavoriteStatus()
            }
            .onChange(of: viewModel.selectedFirstUnitIndex) { _, _ in updateFavoriteStatus() }
            .onChange(of: viewModel.selectedSecondUnitIndex) { _, _ in updateFavoriteStatus() }
            .overlay {
                if showingFavoriteMessage {
                    Text(isFavorite ? "Added to Favorites" : "Removed from Favorites")
                        .padding()
                        .background(Color.indigo.opacity(0.8))
                        .cornerRadius(10)
                        .transition(.move(edge: .top))
                }
            }
        }
        
    private func unitPicker(selection: Binding<Int>) -> some View {
        List {
            ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                Button(unitText(for: index)) {
                    selection.wrappedValue = index
                    showingFromUnitPicker = false
                    showingToUnitPicker = false
                }
            }
        }
    }
        
        private func unitText(for index: Int) -> String {
            let unit = viewModel.availableUnits[index]
            return "\(unit.symbol) (\(unit.name))"
        }
        
        private func swapUnitsAndValues() {
            let tempIndex = viewModel.selectedFirstUnitIndex
            viewModel.selectedFirstUnitIndex = viewModel.selectedSecondUnitIndex
            viewModel.selectedSecondUnitIndex = tempIndex
        }
        
        private func toggleNegative() {
            if viewModel.firstUnitInputValue.isEmpty {
                return
            }
            
            if viewModel.firstUnitInputValue.hasPrefix("-") {
                viewModel.firstUnitInputValue.removeFirst()
            } else {
                viewModel.firstUnitInputValue = "-" + viewModel.firstUnitInputValue
            }
            
            if viewModel.firstUnitInputValue.last == "." || viewModel.firstUnitInputValue.last == "," {
                viewModel.firstUnitInputValue.removeLast()
            }
        }
        
        private func toggleFavorite() {
            if isFavorite {
                if let favorite = favoritesViewModel.getFavorites().first(where: {
                    $0.category == viewModel.category.rawValue &&
                    $0.fromUnit == viewModel.availableUnits[viewModel.selectedFirstUnitIndex].name &&
                    $0.toUnit == viewModel.availableUnits[viewModel.selectedSecondUnitIndex].name
                }) {
                    favoritesViewModel.removeFavorite(favorite)
            }
        } else {
            favoritesViewModel.addFavorite(
                category: viewModel.category.rawValue,
                fromUnit: viewModel.availableUnits[viewModel.selectedFirstUnitIndex].name,
                toUnit: viewModel.availableUnits[viewModel.selectedSecondUnitIndex].name
            )
        }
        withAnimation {
            isFavorite.toggle()
        }
        showFavoriteMessage()
    }
        
    private func setFromFavorite() {
        if let favorite = favorite {
            viewModel.selectedFirstUnitIndex = viewModel.availableUnits.firstIndex(where: { $0.name == favorite.fromUnit }) ?? 0
            viewModel.selectedSecondUnitIndex = viewModel.availableUnits.firstIndex(where: { $0.name == favorite.toUnit }) ?? 1
        }
    }
    
    private func updateFavoriteStatus() {
        isFavorite = favoritesViewModel.isFavorite(
            category: viewModel.category.rawValue,
            fromUnit: viewModel.availableUnits[viewModel.selectedFirstUnitIndex].name,
            toUnit: viewModel.availableUnits[viewModel.selectedSecondUnitIndex].name
        )
    }
        
    private func showFavoriteMessage() {
        withAnimation {
            showingFavoriteMessage = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                showingFavoriteMessage = false
            }
        }
    }
        
    private func addExponent() {
        if !viewModel.firstUnitInputValue.contains("e") && !viewModel.firstUnitInputValue.isEmpty {
            viewModel.firstUnitInputValue += "e"
        }
    }
}
    
#Preview {
    let viewModel = UnitConversionViewModel(category: CommonUnitsCategory.mass)
    return UnitConversionViewWatch(viewModel: viewModel)
}
