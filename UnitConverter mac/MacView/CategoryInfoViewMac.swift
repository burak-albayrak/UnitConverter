//
//  CategoryInfoViewMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI

struct CategoryInfoViewMac<T: UnitCategory>: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("isDarkMode") private var isDarkMode = false
    var category: T
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                        .font(.title2)
                }
                .buttonStyle(.plain)
                .padding()
            }
            
            VStack {
                Image(systemName: category.icon)
                    .foregroundColor(.cyan)
                    .font(.system(size: 60))
                Text(category.localizedName)
                    .font(.title)
                    .bold()
            }
            .padding(.top, 20)
            
            ScrollView {
                Text(category.info)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .frame(width: 500, height: 400)
        .background(isDarkMode ? Color(.windowBackgroundColor) : .white)
    }
}

#Preview {
    CategoryInfoViewMac(category: CommonUnitsCategory.mass)
}