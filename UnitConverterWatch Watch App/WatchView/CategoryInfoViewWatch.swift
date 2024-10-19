//
//  CategoryInfoViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 19.10.2024.
//

import SwiftUI

struct CategoryInfoViewWatch<T: UnitCategory>: View {
    @Environment(\.dismiss) var dismiss
    var category: T
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image(systemName: category.icon)
                    .foregroundColor(.indigo)
                    .font(.largeTitle)
                
                Text(category.localizedName)
                    .font(.headline)
                    .bold()
                
                Text(category.info)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("OK") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.indigo)
            }
            .padding()
        }
    }
}

#Preview {
    CategoryInfoViewWatch(category: CommonUnitsCategory.mass)
}
