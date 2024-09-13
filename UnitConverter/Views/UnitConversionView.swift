//
//  UnitConversionView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct UnitConversionView<T: UnitCategory>: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel: UnitConversionViewModel<T>
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var copiedToClipboard: Bool = false
    @State private var isCopyButtonPressed: Bool = false
    @State private var isPasteButtonPressed: Bool = false
    @State private var isFavoriteButtonPressed: Bool = false
    @State private var addedToFavorites: Bool = false
    
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
                    Button(action: {
                        if !viewModel.firstUnitInputValue.starts(with: "-") {
                            viewModel.firstUnitInputValue = "-" + viewModel.firstUnitInputValue
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
                    TextField(LocalizedStringKey("Enter value"), text: $viewModel.firstUnitInputValue)
                        .keyboardType(.decimalPad)
                    Text(viewModel.availableUnits[viewModel.selectedFirstUnitIndex].symbol)
                    Spacer()
                    Button(action: {
                        if let pasteboardString = UIPasteboard.general.string {
                            viewModel.firstUnitInputValue = pasteboardString
                        }
                    }) {
                        Text(LocalizedStringKey("paste"))
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
        }
        .sheet(isPresented: $viewModel.isInfoPresented, content: {
            CategoryInfoView(category: viewModel.category)
        })
        .navigationTitle(viewModel.category.localizedName)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    UIApplication.shared.hideKeyboard()
                }, label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .font(.callout)
                        .foregroundColor(.cyan)
                })
                Button(action: {
                    favoritesViewModel.addFavorite(
                        category: viewModel.category.rawValue,
                        fromUnit: viewModel.availableUnits[viewModel.selectedFirstUnitIndex].name,
                        toUnit: viewModel.availableUnits[viewModel.selectedSecondUnitIndex].name
                    )
                    withAnimation(.easeIn(duration: 0.5)) {
                        addedToFavorites = true
                        isFavoriteButtonPressed = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.easeOut(duration: 0.1)) {
                            isFavoriteButtonPressed = false
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeOut(duration: 2)) {
                            addedToFavorites = false
                        }
                    }
                }) {
                    Image(systemName: "star")
                        .font(.title3)
                        .foregroundColor(.cyan)
                }
                Button(action: {
                    viewModel.isInfoPresented = true
                }, label: {
                    Image(systemName: "info.circle")
                        .font(.title3)
                        .foregroundColor(.cyan)
                })

            }
        }
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
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
    
    private func unitText(for index: Int) -> String {
        let unit = viewModel.availableUnits[index]
        return "\(unit.symbol) (\(unit.name))"
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
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return UnitConversionView(viewModel: UnitConversionViewModel<CommonUnitsCategory>(category: .mass))
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
