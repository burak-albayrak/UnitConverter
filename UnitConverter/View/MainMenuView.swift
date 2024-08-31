//
//  MainMenu.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Common Converters") {
                    ForEach(Category.allCases, id: \.self) { category in
                        NavigationLink {
                            UnitConversionView(viewModel: DetailViewModel(category: category))
                        } label: {
                            Label(category.rawValue, systemImage: category.icon)
                        }
                    }
                }
                
                Section("All Converters") {
                    NavigationLink {
                        AdvencedUnitsMenu()
                    } label: {
                        Label("Engineering Converters", systemImage: "wrench.and.screwdriver")
                    }
                    NavigationLink {
                        AdvencedUnitsMenu()
                    } label: {
                        Label("Heat Converters", systemImage: "flame")
                    }
                    NavigationLink {
                        AdvencedUnitsMenu()
                    } label: {
                        Label("Fluids Converters", systemImage: "drop")
                    }
                    NavigationLink {
                        AdvencedUnitsMenu()
                    } label: {
                        Label("Light Converters", systemImage: "lightbulb")
                    }
                    NavigationLink {
                        AdvencedUnitsMenu()
                    } label: {
                        Label("Electricity Converters", systemImage: "bolt")
                    }
                    NavigationLink {
                        AdvencedUnitsMenu()
                    } label: {
                        Label("Magnetism Converters", systemImage: "bolt.batteryblock")
                    }
                }
                
                Section {
                    Text("// BUY ME A COFFEE //") // TODO: add payment system
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    MainMenuView()
}

// TODO: improve info section ✅
// TODO: add Copy and Paste Buttons ✅
// TODO: improve UnitConversation View ✅
// TODO: divide Categories ✅

// TODO: add history section with SwiftData
// TODO: add fav section with SwiftData I guess??

// FIXME: fix unit order and base orders

// TODO: ADD price convertions
// TODO: add convert case ***

// TODO: Dark mode
// TODO: Dil desteği

