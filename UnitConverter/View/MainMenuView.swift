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
                
                Section("Price Converter") {
                    NavigationLink {
                        CurrencyConversionView()
                    } label: {
                        Label("Currency", systemImage: "dollarsign.circle")
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
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    MainMenuView()
}

// islerrrrrr

// TODO: tüm unit dönüşümlerini teker teker kontrol et ve bitir. dönüşümleri, logoları, açıklamaları.

// TODO: birimlerin ilk girinceki unit'leri ayarla

// TODO: add history section with SwiftData

// TODO: add fav section with SwiftData I guess??

// pre-Final

// TODO: improve info section
// TODO: improve UnitConversation View

// FINAL

// TODO: Dark mode kontrol
// TODO: Dil desteği
// TODO: uygulama rengi belirle.

// Extralar

// TODO: widget ????
// TODO: control center button ????
// TODO: info kısmı için wikipedia linkleri koyulabilir.

// TODO: add convert case (text inputum yok. farklı bir mac app olabilir.)
