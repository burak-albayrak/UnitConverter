//
//  FavoritesViewModel.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 8.09.2024.
//

import SwiftUI
import SwiftData

@MainActor
class FavoritesViewModel: ObservableObject {
    private var modelContext: ModelContext?
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func getFavorites() -> [FavoriteConversion] {
        guard let modelContext = modelContext else { return [] }
        return (try? modelContext.fetch(FetchDescriptor<FavoriteConversion>())) ?? []
    }
    func addFavorite(category: String, fromUnit: String, toUnit: String) {
        guard let modelContext = modelContext else { return }
        
        let actualCategory = category == CurrencyUnitsCategory.currency.rawValue ? "Currency" : category
        
        let newFavorite = FavoriteConversion(category: actualCategory, fromUnit: fromUnit, toUnit: toUnit)
        modelContext.insert(newFavorite)
    }
    
    func removeFavorite(_ favorite: FavoriteConversion) {
        guard let modelContext = modelContext else { return }
        modelContext.delete(favorite)
    }
    
    func clearAllFavorites() {
        guard let modelContext = modelContext else { return }
        do {
            try modelContext.delete(model: FavoriteConversion.self)
        } catch {
            print("Failed to clear favorites: \(error)")
        }
    }
}
