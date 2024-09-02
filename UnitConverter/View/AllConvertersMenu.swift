//
//  AllUnitsView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct AllConvertersMenu: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(CommonUnitsCategory.allCases, id: \.self) { category in
                    NavigationLink {
                        UnitConversionView(viewModel: UnitConversionViewModel(category: category))
                    } label: {
                        Label(category.rawValue, systemImage: category.icon)
                    }
                }
            }
        }
        .navigationTitle("seçilen ünit")
    }
}

#Preview {
    AllConvertersMenu()
}
