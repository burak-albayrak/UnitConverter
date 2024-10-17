//
//  MainMenuViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI

struct MainMenuViewWatch: View {
    @State private var showSettings = false
    @State private var showFavorites = false
    
    var body: some View {
        List {
            Section("Common") {
                ForEach(CommonUnitsCategory.allCases.prefix(3), id: \.self) { category in
                    NavigationLink(destination: UnitConversionViewWatch(viewModel: UnitConversionViewModel(category: category))) {
                        Label(category.localizedName, systemImage: category.icon)
                    }
                }
            }
            
            Section("Currency") {
                NavigationLink(destination: CurrencyConverterViewWatch()) {
                    Label("Currency", systemImage: "dollarsign.circle")
                }
            }
            
            Section("All") {
                NavigationLink(destination: AllConvertersMenuWatch(category: .fluidsConverters)) {
                    Label("All Converters", systemImage: "list.bullet")
                }
            }
            
            Section("More") {
                Button(action: { showFavorites = true }) {
                    Label("Favorites", systemImage: "star.fill")
                }
                Button(action: { showSettings = true }) {
                    Label("Settings", systemImage: "gear")
                }
            }
        }
        .listStyle(CarouselListStyle())
        .navigationTitle("Converter")
        .sheet(isPresented: $showSettings) {
            SettingsViewWatch()
        }
        .sheet(isPresented: $showFavorites) {
            FavoritesViewWatch()
        }
    }
}

#Preview {
    MainMenuViewWatch()
}
