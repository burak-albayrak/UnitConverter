//
//  WelcomeViewWatch.swift
//  UnitConverterWatch Watch App
//
//  Created by Burak Albayrak on 18.10.2024.
//

import SwiftUI

struct WelcomeViewWatch: View {
    @State private var currentPage = 0
    @Binding var showWelcomeScreen: Bool
    
    let pages: [WelcomePage] = [
        WelcomePage(
            titleKey: "WelcomeTitle",
            descriptionKey: "WelcomeDescription",
            imageName: "WelcomeImageWatch",
            isSymbol: false
        ),
        WelcomePage(
            titleKey: "CategoriesTitle",
            descriptionKey: "CategoriesDescription",
            imageName: "rectangle.stack",
            isSymbol: true
        ),
        WelcomePage(
            titleKey: "FavoritesTitle",
            descriptionKey: "FavoritesDescription",
            imageName: "star",
            isSymbol: true
        ),
        WelcomePage(
            titleKey: "GetStartedTitle",
            descriptionKey: "GetStartedDescription",
            imageName: "arrow.2.squarepath",
            isSymbol: true
        )
    ]
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<pages.count, id: \.self) { index in
                VStack {
                    Group {
                        if pages[index].isSymbol {
                            Image(systemName: pages[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.indigo)
                        } else {
                            Image(pages[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                    }
                    
                    Text(pages[index].titleKey)
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                    
                    Text(pages[index].descriptionKey)
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                    
                    Spacer(minLength: 40)
                    Button(action: {
                        if currentPage < pages.count - 1 {
                            withAnimation {
                                currentPage += 1
                            }
                        } else {
                            showWelcomeScreen = false
                        }
                    }) {
                        Text(currentPage < pages.count - 1 ? "Next" : "Start")
                            .fontWeight(.bold)
                            .frame(height: 25)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.indigo)
                            .cornerRadius(25)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct WelcomePage {
    let titleKey: LocalizedStringKey
    let descriptionKey: LocalizedStringKey
    let imageName: String
    let isSymbol: Bool
}

#Preview {
    struct PreviewWrapper: View {
        @State private var showWelcomeScreen = true
        
        var body: some View {
            WelcomeViewWatch(showWelcomeScreen: $showWelcomeScreen)
        }
    }
    
    return PreviewWrapper()
}
