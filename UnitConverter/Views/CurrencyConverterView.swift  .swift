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
    @State private var isCopyButtonPressed: Bool = false
    @State private var isPasteButtonPressed: Bool = false

    var body: some View {
        Form {
            Section("Select Currencies") {
                Picker("From Currency", selection: $viewModel.selectedFromCurrencyIndex) {
                    ForEach(0 ..< viewModel.availableCurrencies.count, id: \.self) { index in
                        Text("\(viewModel.availableCurrencies[index].symbol) (\(viewModel.availableCurrencies[index].name))")
                    }
                }
                .onChange(of: viewModel.selectedFromCurrencyIndex) { _, _ in
                    viewModel.convertCurrency()
                }
                
                Picker("To Currency", selection: $viewModel.selectedToCurrencyIndex) {
                    ForEach(0 ..< viewModel.availableCurrencies.count, id: \.self) { index in
                        Text("\(viewModel.availableCurrencies[index].symbol) (\(viewModel.availableCurrencies[index].name))")
                    }
                }
                .onChange(of: viewModel.selectedToCurrencyIndex) { _, _ in
                    viewModel.convertCurrency()
                }
            }
            
            Section("Value") {
                HStack {
                    TextField("Enter value", text: $viewModel.inputValue)
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
                        Text(errorMessage)
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
        }
        .navigationTitle("Currency")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    UIApplication.shared.hideKeyboard()
                }, label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .font(.title3)
                        .foregroundColor(.cyan)
                })
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
