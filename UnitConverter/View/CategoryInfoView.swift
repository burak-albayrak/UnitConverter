//
//  CategoryInfoView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct CategoryInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var category: CommonUnitsCategory
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: category.icon)
                    .foregroundColor(.blue)
                Text(category.rawValue)
                    .bold()
            }
            .padding(.top, 40)
            .font(.largeTitle)

            Text(category.info)
                .padding(30)
                .multilineTextAlignment(.center)
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 27)
                        .frame(width: 160, height: 54)
                    .foregroundStyle(.blue.gradient)
                    Text("OK")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                }

            })
                .padding(.bottom, 60)
        }
    }
}

#Preview {
    CategoryInfoView(category: .mass)
}
