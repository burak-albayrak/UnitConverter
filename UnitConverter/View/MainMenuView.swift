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
                    ForEach(CommonUnitsCategory.allCases, id: \.self) { category in
                        NavigationLink {
                            UnitConversionView(viewModel: UnitConversionViewModel(category: category))
                        } label: {
                            Label(category.rawValue, systemImage: category.icon)
                        }
                    }
                }
                
                Section("All Converters") {
                    ForEach(AllConvertersCategory.allCases, id: \.self) { category in
                        NavigationLink {
                            AllConvertersMenu()
                        } label: {
                            Label(category.rawValue, systemImage: category.icon)
                        }
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

// TODO: Dark mode ✅
// TODO: Dil desteği

