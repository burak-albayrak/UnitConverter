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
        NavigationStack {
            List {
                Section("Common") {
                    ForEach(CommonUnitsCategory.allCases, id: \.self) { category in
                        NavigationLink {
                            UnitConversionViewWatch(viewModel: UnitConversionViewModel(category: category))
                        } label: {
                            Label(category.localizedName, systemImage: category.icon)
                        }
                    }
                }
                
                Section("Currency") {
                    NavigationLink {
                        CurrencyConverterViewWatch(presentingModal: false)
                    } label: {
                        Label("Currency", systemImage: "dollarsign.circle")
                    }
                }
                
                Section("All Converters") {
                    ForEach(AllConvertersCategory.allCases) { category in
                        NavigationLink {
                            AllConvertersMenuWatch(category: category)
                        } label: {
                            Label(category.localizedName, systemImage: category.icon)
                        }
                    }
                }
                
                Section {
                    Button(action: { showFavorites = true }) {
                        Label("Favorites", systemImage: "star.fill")
                    }
                    Button(action: { showSettings = true }) {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
            .listStyle(CarouselListStyle())
            .navigationTitle("Unit Converter")
        }
        .sheet(isPresented: $showSettings) {
            SettingsViewWatch()
        }
        .sheet(isPresented: $showFavorites) {
            FavoritesViewWatch()
        }
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return MainMenuViewWatch()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
