//
//  SettingsView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 8.09.2024.
//

import SwiftUI
import SwiftData
import MessageUI
import StoreKit

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var showingClearConfirmation = false
    @State private var isShowingMailView = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @StateObject private var storeKit = StoreKitManager()
    @State private var showingPurchaseAlert = false
    @State private var purchaseAlertMessage = ""

    var body: some View {
        NavigationView {
            Form {


                
                Section(header: Text("Favorites")) {
                    Button("Clear All Favorites") {
                        showingClearConfirmation = true
                    }
                    .foregroundColor(.red)
                }
                
                Section(header: Text("Support Me")) {
                    Button("Buy Me a Coffee") {
                        storeKit.purchaseCoffee()
                    }
                    .disabled(storeKit.isLoading)
                }
                
                Section(header: Text("Feedback")) {
                    Button("Feedback Me") {
                        isShowingMailView = true
                    }
                }
                
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: $mailResult) { composer in
                composer.setSubject("Feedback for Unit Converter App")
                composer.setToRecipients(["burak_albayrak0@icloud.com"])
            }
        }
        .onAppear {
            favoritesViewModel.setModelContext(modelContext)
        }
        .alert(isPresented: $showingPurchaseAlert) {
            Alert(title: Text("Purchase"), message: Text(purchaseAlertMessage), dismissButton: .default(Text("OK")))
        }
        .onReceive(storeKit.$purchaseResult) { result in
            if let result = result {
                showingPurchaseAlert = true
                switch result {
                case .success:
                    purchaseAlertMessage = "Thank you for your support!"
                case .failure(let error):
                    purchaseAlertMessage = "Purchase failed: \(error.localizedDescription)"
                }
            }
        }
        .alert("Clear All Favorites", isPresented: $showingClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                favoritesViewModel.clearAllFavorites()
            }
        } message: {
            Text("Are you sure you want to clear all favorites? This action cannot be undone.")
        }
        
        Text(getAppVersion())
            .foregroundColor(.secondary)
            .padding(.top, 20)
    }
    
    func getAppVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "version \(version)"
    }
}

#Preview {
    do {
        let container = try PreviewContainer().container
        return SettingsView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
