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
    
    var body: some View {
        Form {
            Section("Select Units") {
                Picker("From Unit", selection: $viewModel.selectedFirstUnitIndex) {
                    ForEach(0 ..< viewModel.availableUnits.count, id: \.self) { index in
                        Text("\(viewModel.availableUnits[index].symbol) (\(viewModel.availableUnitNames[index]))")
                    }
                }
                Picker("To Unit", selection: $viewModel.selectedSecondUnitIndex) {
                    ForEach(0 ..< viewModel.availableUnits.count, id: \.self) { index in
                        Text("\(viewModel.availableUnits[index].symbol) (\(viewModel.availableUnitNames[index]))")
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
                    }
                    .padding(9)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .containerShape(.rect(cornerRadius: 10))
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
                    }
                    .padding(9)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .containerShape(.rect(cornerRadius: 10))
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
}

#Preview {
    UnitConversionView(viewModel: UnitConversionViewModel<CommonUnitsCategory>(category: .mass))
}
