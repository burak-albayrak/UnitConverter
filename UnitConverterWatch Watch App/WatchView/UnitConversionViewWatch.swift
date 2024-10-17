//
//  UnitConversionViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI

struct UnitConversionViewWatch<T: UnitCategory>: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: UnitConversionViewModel<T>
    @State private var showingUnitPicker = false
    @State private var isSelectingFromUnit = true

    var body: some View {
        List {
            Section {
                HStack {
                    Text("From:")
                    Spacer()
                    Button(unitText(for: viewModel.selectedFirstUnitIndex)) {
                        isSelectingFromUnit = true
                        showingUnitPicker = true
                    }
                }
                HStack {
                    Text("To:")
                    Spacer()
                    Button(unitText(for: viewModel.selectedSecondUnitIndex)) {
                        isSelectingFromUnit = false
                        showingUnitPicker = true
                    }
                }
            }
            
            Section("Value") {
                TextField("Enter value", text: $viewModel.firstUnitInputValue)
            }
            
            Section("Result") {
                Text(viewModel.convertUnits(value: viewModel.firstUnitInputValue))
            }
            
            Button("Swap") {
                swapUnitsAndValues()
            }
        }
        .navigationTitle(viewModel.category.localizedName)
        .sheet(isPresented: $showingUnitPicker) {
            unitPicker
        }
    }
    
    private var unitPicker: some View {
        List {
            ForEach(viewModel.availableUnitsIndices, id: \.self) { index in
                Button(unitText(for: index)) {
                    if isSelectingFromUnit {
                        viewModel.selectedFirstUnitIndex = index
                    } else {
                        viewModel.selectedSecondUnitIndex = index
                    }
                    showingUnitPicker = false
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
}

#Preview {
    let viewModel = UnitConversionViewModel(category: CommonUnitsCategory.mass)
    return UnitConversionViewWatch(viewModel: viewModel)
}
