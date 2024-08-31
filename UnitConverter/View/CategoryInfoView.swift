//
//  CategoryInfoView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 31.08.2024.
//

import SwiftUI

struct CategoryInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var category: Category
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: category.icon)
                    .foregroundColor(.blue)
                Text(category.rawValue)
                    .font(.title2)
                    .bold()
            }
            .padding(.top, 70)

            Text(category.info)
                .padding(20)
            
            Spacer()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("OK")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 280, height: 44)
                    .background(Color.blue)
                    .cornerRadius(12)
            })
                .padding(.bottom, 60)
        }
    }
}

#Preview {
    CategoryInfoView(category: .mass)
}
