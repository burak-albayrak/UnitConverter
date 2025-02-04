//
//  UnitConversionViewIPad.swift
//  UnitConverterIPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI

struct UnitConversionViewIPad<T: UnitCategory>: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: UnitConversionViewModel<T>
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var copiedToClipboard: Bool = false
    @State private var isCopyButtonPressed: Bool = false
    @State private var isPasteButtonPressed: Bool = false
    @State private var isFavoriteButtonPressed: Bool = false
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
            Section(LocalizedStringKey("Select Units")) {
                Picker(LocalizedStringKey("From Unit"), selection: $viewModel.selectedFirstUnitIndex) {
                    ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                        Text(unitText(for: index))
                    }
                }
                Picker(LocalizedStringKey("To Unit"), selection: $viewModel.selectedSecondUnitIndex) {
                    ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                        Text(unitText(for: index))
                    }
                }
            }
            
            Section("Value") {
                HStack {
                    TextField("Enter Value", text: $viewModel.firstUnitInputValue)
                        .keyboardType(.decimalPad)
                        .onChange(of: viewModel.firstUnitInputValue) { _, newValue in
                            let allowedCharacters = CharacterSet(charactersIn: "0123456789eE-.,")
                            let filtered = newValue.filter { char in
                                String(char).rangeOfCharacter(from: allowedCharacters) != nil
                            }
                            if filtered != newValue {
                                viewModel.firstUnitInputValue = filtered
                            }
                        }
                    Text(viewModel.availableUnits[viewModel.selectedFirstUnitIndex].symbol)
                    Spacer()
                    Button(action: {
                        if let pasteboardString = UIPasteboard.general.string {
                            let filteredString = pasteboardString.filter { "0123456789.,".contains($0) }
                            viewModel.firstUnitInputValue = filteredString
                        }
                    }) {
                        Text(LocalizedStringKey("paste"))
                            .padding(9)
                            .padding(.horizontal)
                            .foregroundColor(.accentColor)
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
                    let convertedValue = viewModel.convertUnits(value: viewModel.firstUnitInputValue)
                    
                    Text(convertedValue)
                    Spacer()
                    Text(viewModel.availableUnits[viewModel.selectedSecondUnitIndex].symbol)
                    Button(action: {
                        UIPasteboard.general.string = convertedValue
                        withAnimation(.easeIn(duration: 0.5)) {
                            copiedToClipboard = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeOut(duration: 2)) {
                                copiedToClipboard = false
                            }
                        }
                    }) {
                        Text(LocalizedStringKey("copy"))
                            .padding(9)
                            .padding(.horizontal)
                            .foregroundColor(.accentColor)
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
                Button(action: swapUnitsAndValues) {
                    HStack {
                        Spacer()
                        Image(systemName: "arrow.up.arrow.down")
                        Text(LocalizedStringKey("Swap"))
                        Spacer()
                    }
                }
                .foregroundColor(.accentColor)
            }
        }
        .navigationTitle(viewModel.category.localizedName)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    UIApplication.shared.hideKeyboard()
                }, label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .font(.callout)
                        .foregroundColor(.accentColor)
                })
                Button(action: {
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
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .font(.title3)
                        .foregroundColor(.accentColor)
                        .scaleEffect(isFavoriteButtonPressed ? 1.2 : 1.0)
                }
                Button(action: {
                    viewModel.isInfoPresented = true
                }, label: {
                    Image(systemName: "info.circle")
                        .font(.title3)
                        .foregroundColor(.accentColor)
                })
            }
        }
        .sheet(isPresented: $viewModel.isInfoPresented, content: {
            CategoryInfoViewIPad(category: viewModel.category)
        })
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
            updateFavoriteStatus()
        }
        .onChange(of: viewModel.selectedFirstUnitIndex) { _,_ in updateFavoriteStatus() }
        .onChange(of: viewModel.selectedSecondUnitIndex) { _,_ in updateFavoriteStatus() }
        .overlay {
            if copiedToClipboard {
                feedbackOverlay(message: LocalizedStringKey("Copied to Clipboard"))
            }
            if addedToFavorites {
                feedbackOverlay(message: LocalizedStringKey("Added to Favorites"))
            }
        }
    }
    
    private func unitText(for index: Int) -> String {
        let unit = viewModel.availableUnits[index]
        return "\(unit.symbol) (\(unit.name))"
    }
    
    private func feedbackOverlay(message: LocalizedStringKey) -> some View {
        Text(message)
            .font(.system(.body, design: .rounded, weight: .semibold))
            .foregroundStyle(.white)
            .padding()
            .background(Color.accentColor.cornerRadius(20))
            .padding(.bottom)
            .shadow(radius: 5)
            .transition(.move(edge: .bottom))
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    private func swapUnitsAndValues() {
        let tempIndex = viewModel.selectedFirstUnitIndex
        viewModel.selectedFirstUnitIndex = viewModel.selectedSecondUnitIndex
        viewModel.selectedSecondUnitIndex = tempIndex
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
        return UnitConversionViewIPad(viewModel: UnitConversionViewModel<CommonUnitsCategory>(category: .mass))
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
