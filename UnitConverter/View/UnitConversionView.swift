//
//  UnitConversionView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct UnitConversionView<T: UnitCategory>: View {
    @StateObject var viewModel: UnitConversionViewModel<T>
    @State private var copiedToClipboard: Bool = false
    @State private var isCopyButtonPressed: Bool = false
    @State private var isPasteButtonPressed: Bool = false
    
    var body: some View {
        Form {
            Section("Select Units") {
                Picker("From Unit", selection: $viewModel.selectedFirstUnitIndex) {
                    ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                        Text(unitText(for: index))
                    }
                }
                Picker("To Unit", selection: $viewModel.selectedSecondUnitIndex) {
                    ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                        Text(unitText(for: index))
                    }
                }
            }
            
            Section("Value") {
                HStack {
                    TextField("Enter value to convert", text: $viewModel.firstUnitInputValue)
                        .keyboardType(.decimalPad)
                    Spacer()
                    Button(action: {
                        if let pasteboardString = UIPasteboard.general.string {
                            viewModel.firstUnitInputValue = pasteboardString
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
                    let convertedValue = viewModel.convertUnits(value: viewModel.firstUnitInputValue)
                    
                    Text("\(convertedValue) \(viewModel.availableUnits[viewModel.selectedSecondUnitIndex].symbol)")
                    Spacer()
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
        }
        .sheet(isPresented: $viewModel.isInfoPresented, content: {
            CategoryInfoView(category: viewModel.category)
        })
        .navigationTitle(viewModel.category.rawValue)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {
                    // hideKeyboard()
                }, label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                })
                Button(action: {
                    viewModel.isInfoPresented = true
                }, label: {
                    Image(systemName: "info.circle")
                })
            }
        }
        .overlay {
            if copiedToClipboard {
                Text("Copied to Clipboard")
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
    }
    
    private func unitText(for index: Int) -> String {
        let unit = viewModel.availableUnits[index]
        return "\(unit.symbol) (\(unit.name))"
    }
}

#Preview {
    UnitConversionView(viewModel: UnitConversionViewModel<CommonUnitsCategory>(category: .mass))
}
