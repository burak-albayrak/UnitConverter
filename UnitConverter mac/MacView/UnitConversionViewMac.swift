//
//  UnitConversionViewMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI

struct UnitConversionViewMac<T: UnitCategory>: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: UnitConversionViewModel<T>
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var copiedToClipboard: Bool = false
    @State private var addedToFavorites: Bool = false
    @State private var isFavorite: Bool = false
    
    init(viewModel: UnitConversionViewModel<T>, favorite: FavoriteConversion? = nil) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        if let favorite = favorite {
            viewModel.setFromFavorite(favorite)
        }
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    VStack(alignment: .leading) {
                        Text("From Unit")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("", selection: $viewModel.selectedFirstUnitIndex) {
                            ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                                Text(unitText(for: index))
                            }
                        }
                        .labelsHidden()
                        .frame(width: 200)
                    }
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("To Unit")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("", selection: $viewModel.selectedSecondUnitIndex) {
                            ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                                Text(unitText(for: index))
                            }
                        }
                        .labelsHidden()
                        .frame(width: 200)
                    }
                }
                .padding()
            }
            
            Section {
                HStack {
                    TextField("Enter value", text: $viewModel.firstUnitInputValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                    
                    Text(viewModel.availableUnits[viewModel.selectedFirstUnitIndex].symbol)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        if let pasteboardString = NSPasteboard.general.string(forType: .string) {
                            let filteredString = pasteboardString.filter { "0123456789.,".contains($0) }
                            viewModel.firstUnitInputValue = filteredString
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
                    let convertedValue = viewModel.convertUnits(value: viewModel.firstUnitInputValue)
                    Text(convertedValue)
                        .font(.title2)
                    Text(viewModel.availableUnits[viewModel.selectedSecondUnitIndex].symbol)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(convertedValue, forType: .string)
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
            
            Button(action: swapUnitsAndValues) {
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
                Button(action: {
                    toggleFavorite()
                }) {
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
        .onChange(of: viewModel.selectedFirstUnitIndex) { updateFavoriteStatus() }
        .onChange(of: viewModel.selectedSecondUnitIndex) { updateFavoriteStatus() }
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
            category: viewModel.category.rawValue,
            fromUnit: viewModel.availableUnits[viewModel.selectedFirstUnitIndex].name,
            toUnit: viewModel.availableUnits[viewModel.selectedSecondUnitIndex].name
        )
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return UnitConversionViewMac(viewModel: UnitConversionViewModel<CommonUnitsCategory>(category: .mass))
            .modelContainer(container)
            .frame(width: 600, height: 400)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
