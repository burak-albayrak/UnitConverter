//
//  CurrencyConverterView.swift  .swift
//  UnitConverter
//
//  Created by Burak Albayrak on 7.09.2024.
//

import SwiftUI

struct CurrencyConversionView: View {
    @StateObject private var viewModel = CurrencyConversionViewModel()
    @State private var copiedToClipboard: Bool = false

    var body: some View {
        Form {
            Section("Select Currencies") {
                Picker("From Currency", selection: $viewModel.selectedFromCurrencyIndex) {
                    ForEach(0 ..< viewModel.category.availableUnits.count, id: \.self) { index in
                        Text("\(viewModel.category.availableUnits[index].symbol) (\(viewModel.category.availableUnitNames[index]))")
                    }
                }
                .onChange(of: viewModel.selectedFromCurrencyIndex) { _, _ in
                    viewModel.convertCurrency()
                }
                
                Picker("To Currency", selection: $viewModel.selectedToCurrencyIndex) {
                    ForEach(0 ..< viewModel.category.availableUnits.count, id: \.self) { index in
                        Text("\(viewModel.category.availableUnits[index].symbol) (\(viewModel.category.availableUnitNames[index]))")
                    }
                }
                .onChange(of: viewModel.selectedToCurrencyIndex) { _, _ in
                    viewModel.convertCurrency()
                }
            }
            
            Section("Value") {
                HStack {
                    TextField("Enter value to convert", text: $viewModel.inputValue)
                        .keyboardType(.decimalPad)
                        .onChange(of: viewModel.inputValue) { _, _ in
                            viewModel.convertCurrency()
                    }
                    Spacer()
                    Button(action: {
                        if let pasteboardString = UIPasteboard.general.string {
                            viewModel.inputValue = pasteboardString
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
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else {
                        Text("\(viewModel.convertedValue) \(viewModel.category.availableUnits[viewModel.selectedToCurrencyIndex].symbol)")
                    }
                    Spacer()
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
                    }
                    .padding(9)
                    .padding(.horizontal)
                    .background(.ultraThinMaterial)
                    .containerShape(.rect(cornerRadius: 10))
                }
            }
        }
        .navigationTitle("Currency")
        .toolbar {
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
        .sheet(isPresented: $viewModel.isInfoPresented) {
            CategoryInfoView(category: viewModel.category)
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
    CurrencyConversionView()
}
