//
//  CategoryInfoView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct CategoryInfoView<T: UnitCategory>: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode = false
    var category: T
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: category.icon)
                    .foregroundColor(.cyan)
                Text(category.localizedName)
                    .bold()
            }
            .padding(.top, 40)
            .font(.largeTitle)
            
            ScrollView {
                Text(category.info)
                    .padding(.horizontal, 33)
                    .padding(.vertical, 5)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Spacer()
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 27)
                        .frame(width: 160, height: 54)
                        .foregroundStyle(.cyan.gradient)
                    Text("OK")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                }
                
            })
            .padding(.bottom, 20)
        }
        .background(isDarkMode ? Color.black : Color.white)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
    }
}

#Preview {
    CategoryInfoView(category: CommonUnitsCategory.mass)
}
