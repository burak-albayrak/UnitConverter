//
//  AppReviewManager.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 10.09.2024.
//

import SwiftUI
import StoreKit

class AppReviewManager: ObservableObject {
    private let launchCountKey = "appLaunchCount"
    private let reviewThreshold = 15
    
    init() {
        incrementLaunchCount()
        checkIfReviewShouldBeRequested()
    }
    
    private func incrementLaunchCount() {
        let currentCount = UserDefaults.standard.integer(forKey: launchCountKey)
        UserDefaults.standard.set(currentCount + 1, forKey: launchCountKey)
    }
    
    func checkIfReviewShouldBeRequested() {
        let currentCount = UserDefaults.standard.integer(forKey: launchCountKey)
        if currentCount % reviewThreshold == 0 {
            requestReview()
        }
    }
    
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
