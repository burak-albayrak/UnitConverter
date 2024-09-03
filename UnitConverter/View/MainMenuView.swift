//
//  MainMenu.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct MainMenuView: View {
    @State private var selectedCategory: AllConvertersCategory?
    @State private var selectedUnitCategory: UnitCategory?
    
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
                    ForEach(AllConvertersCategory.allCases) { category in
                        NavigationLink {
                            AllConvertersMenu(category: category)
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



// FIXME: paste button

// Ugrastirici isler

// TODO: tüm unitlerin açıklamalarını ve logolarını ayarla (belki hepsine wikipedia linki)

// TODO: birimlerin yanında isimleri yazmalı

// TODO: birimlerin sırasını ayarla ve ilk girinceki unit'leri ayarla

// TODO: tüm unit dönüşümlerini ayarla

// TODO: ADD price convertions (internetten güncel çekmeli)

// TODO: add convert case ***



// Zor islerrrrr

// TODO: add history section with SwiftData
// TODO: add fav section with SwiftData I guess??


// pre-Final

// TODO: improve info section
// TODO: improve UnitConversation View


// FINAL

// TODO: Dark mode ✅
// TODO: Dil desteği
// TODO: uygulama rengi belirle.
