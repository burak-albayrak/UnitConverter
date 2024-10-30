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
            Section(LocalizedStringKey("Select Units")) {
                Picker(LocalizedStringKey("From Unit"), selection: $viewModel.selectedFirstUnitIndex) {
                    ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                        Text(unitText(for: index))
                    }
                }
                
                HStack {
                    Spacer()
                    Button(action: swapUnitsAndValues) {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.title2)
                    }
                    .buttonStyle(.borderless)
                    Spacer()
                }
                
                Picker(LocalizedStringKey("To Unit"), selection: $viewModel.selectedSecondUnitIndex) {
                    ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                        Text(unitText(for: index))
                    }
                }
            }
            
            Section(LocalizedStringKey("Value")) {
                HStack {
                    CustomTextField(text: $viewModel.firstUnitInputValue, placeholder: "Enter value")
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
                    .buttonStyle(TransparentButtonStyle())
                }
            }

            Section(LocalizedStringKey("Result")) {
                HStack {
                    let convertedValue = viewModel.convertUnits(value: viewModel.firstUnitInputValue)
                    Text(convertedValue)
                        .font(.title2)
                    Text(viewModel.availableUnits[viewModel.selectedSecondUnitIndex].symbol)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(viewModel.convertUnits(value: viewModel.firstUnitInputValue), forType: .string)
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
        .formStyle(.grouped)
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Spacer()
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
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
            updateFavoriteStatus()
        }
        .onChange(of: viewModel.selectedFirstUnitIndex) { updateFavoriteStatus() }
        .onChange(of: viewModel.selectedSecondUnitIndex) { updateFavoriteStatus() }
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

    
    private func unitText(for index: Int) -> String {
        let unit = viewModel.availableUnits[index]
        return "\(unit.name) (\(unit.symbol))"
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
    
    private func swapUnitsAndValues() {
        let tempIndex = viewModel.selectedFirstUnitIndex
        viewModel.selectedFirstUnitIndex = viewModel.selectedSecondUnitIndex
        viewModel.selectedSecondUnitIndex = tempIndex
    }
    
    private func updateFavoriteStatus() {
        isFavorite = favoritesViewModel.isFavorite(
            category: viewModel.category.rawValue,
            fromUnit: viewModel.availableUnits[viewModel.selectedFirstUnitIndex].symbol,
            toUnit: viewModel.availableUnits[viewModel.selectedSecondUnitIndex].symbol
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

struct CustomTextField: NSViewRepresentable {
    @Binding var text: String
    var placeholder: String
    
    func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField()
        textField.placeholderString = placeholder
        textField.delegate = context.coordinator
        textField.alignment = .left
        textField.bezelStyle = .roundedBezel
        return textField
    }
    
    func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.stringValue = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, NSTextFieldDelegate {
        var text: Binding<String>
        
        init(text: Binding<String>) {
            self.text = text
        }
        
        func controlTextDidChange(_ obj: Notification) {
            if let textField = obj.object as? NSTextField {
                self.text.wrappedValue = textField.stringValue
            }
        }
    }
}

struct TransparentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(Color.accentColor.opacity(configuration.isPressed ? 0.1 : 0.2))
            .cornerRadius(8)
            .foregroundColor(.accentColor)
    }
}
