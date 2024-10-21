//
//  CategoryInfoViewIPad.swift
//  UnitConverterIPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI

struct CategoryInfoViewIPad<T: UnitCategory>: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var sizeClass
    @AppStorage("isDarkMode") private var isDarkMode = false
    var category: T
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 20) {
                    Image(systemName: category.icon)
                        .foregroundColor(.cyan)
                        .font(.system(size: 60))
                    Text(category.localizedName)
                        .bold()
                        .font(.system(size: 40))
                }
                .padding(.top, geometry.size.height * 0.05)
                
                ScrollView {
                    Text(category.info)
                        .padding(.horizontal, geometry.size.width * 0.1)
                        .padding(.vertical, 20)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20))
                }
                .frame(maxWidth: 800)
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("OK")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 60)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color.cyan.gradient))
                }
                .padding(.bottom, geometry.size.height * 0.05)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(isDarkMode ? Color.black : Color.white)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    CategoryInfoViewIPad(category: CommonUnitsCategory.mass)
}
