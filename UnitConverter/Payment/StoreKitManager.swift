//
//  StoreKitManager.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 9.09.2024.
//

import StoreKit

class StoreKitManager: ObservableObject {
    @Published var isLoading = false
    @Published var purchaseResult: Result<Bool, Error>?
    
    private var products: [Product] = []
    private let productIdentifiers = ["com.yourapp.coffee"]
    // App Store Connect'te oluşturduğunuz ürün ID'si
    // FIXME: Apple Dev alınca yap!!!!
    
    init() {
        Task {
            await loadProducts()
        }
    }
    
    @MainActor
    func loadProducts() async {
        do {
            products = try await Product.products(for: productIdentifiers)
        } catch {
            print("Failed to load products: \(error)")
        }
    }
    
    func purchaseCoffee() {
        guard let product = products.first else {
            purchaseResult = .failure(NSError(domain: "StoreKitManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No products available"]))
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let result = try await product.purchase()
                switch result {
                case .success(let verificationResult):
                    switch verificationResult {
                    case .verified(let transaction):
                        await transaction.finish()
                        await MainActor.run {
                            purchaseResult = .success(true)
                            isLoading = false
                        }
                    case .unverified:
                        throw NSError(domain: "StoreKitManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Transaction unverified"])
                    }
                case .userCancelled:
                    await MainActor.run {
                        purchaseResult = .failure(NSError(domain: "StoreKitManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "User cancelled"]))
                        isLoading = false
                    }
                case .pending:
                    await MainActor.run {
                        purchaseResult = .failure(NSError(domain: "StoreKitManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Purchase pending"]))
                        isLoading = false
                    }
                @unknown default:
                    await MainActor.run {
                        purchaseResult = .failure(NSError(domain: "StoreKitManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"]))
                        isLoading = false
                    }
                }
            } catch {
                await MainActor.run {
                    purchaseResult = .failure(error)
                    isLoading = false
                }
            }
        }
    }
}
