//
//  MainMenu.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Category.allCases, id: \.self) { category in
                    NavigationLink {
                        UnitConversionView(viewModel: DetailViewModel(category: category))
                    } label: {
                        Label(category.rawValue, systemImage: category.icon)
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

// TODO: improve info section
// TODO: divide Categories
// TODO: add advanced mode
// TODO: improve UnitConversation View
// TODO: add Copy and Paste Buttons

// FIXME: fix unit order and base orders

// TODO: ADD price convertions
