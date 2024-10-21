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
            ZStack {
                (isDarkMode ? Color.black : Color.white)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    HStack {
                        Spacer()
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 30))
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 35) {
                        Image(systemName: category.icon)
                            .foregroundColor(.accentColor)
                            .font(.system(size: 40))
                            .background(
                                Circle()
                                    .fill(Color.accentColor.opacity(0.1))
                                    .frame(width: 100, height: 100)
                            )
                            .padding(.bottom, 10)
                        
                        Text(category.localizedName)
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(isDarkMode ? .white : .black)
                        
                    }
                    
                    ScrollView {
                        Text(category.info)
                            .font(.system(size: 22))
                            .foregroundColor(isDarkMode ? .white : .black)
                            .padding(.horizontal, geometry.size.width * 0.1)
                    }
                    .frame(maxWidth: 800)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 20)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    CategoryInfoViewIPad(category: CommonUnitsCategory.mass)
}
