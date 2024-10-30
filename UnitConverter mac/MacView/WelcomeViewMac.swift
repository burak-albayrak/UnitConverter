//
//  WelcomeViewMac.swift
//  UnitConverter mac
//
//  Created by Burak Albayrak on 28.10.2024.
//

import SwiftUI

struct WelcomeViewMac: View {
    @State private var currentPage = 0
    @Binding var showWelcomeScreen: Bool
    @State private var imageScale: CGFloat = 0.5
    @State private var textOpacity: Double = 0
    
    let pages: [WelcomePage] = [
        WelcomePage(
            titleKey: "WelcomeTitle",
            descriptionKey: "WelcomeDescription",
            imageName: "WelcomeImage1",
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
        VStack(spacing: 30) {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    VStack(spacing: 40) {
                        if pages[index].isSymbol {
                            Image(systemName: pages[index].imageName)
                                .font(.system(size: 100))
                                .foregroundColor(.cyan)
                                .scaleEffect(imageScale)
                        } else {
                            Image(pages[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 300)
                                .scaleEffect(imageScale)
                        }
                        
                        VStack(spacing: 20) {
                            Text(pages[index].titleKey)
                                .font(.title)
                                .bold()
                                .opacity(textOpacity)
                            
                            Text(pages[index].descriptionKey)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .opacity(textOpacity)
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(DefaultTabViewStyle())
            .frame(height: 500)
            
            HStack(spacing: 20) {
                ForEach(0..<pages.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.cyan : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                        .onTapGesture {
                            withAnimation {
                                currentPage = index
                            }
                        }
                }
            }
            .padding(.bottom)
            
            Button {
                if currentPage < pages.count - 1 {
                    withAnimation {
                        currentPage += 1
                    }
                } else {
                    showWelcomeScreen = false
                }
            } label: {
                Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 40)
                    .background(Color.cyan)
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
        }
        .frame(width: 600)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeIn(duration: 0.5)) {
                    imageScale = 1.0
                    textOpacity = 1
                }
            }
        }
    }
}

struct WelcomePage {
    let titleKey: LocalizedStringKey
    let descriptionKey: LocalizedStringKey
    let imageName: String
    let isSymbol: Bool
}

#Preview {
    WelcomeViewMac(showWelcomeScreen: .constant(true))
}
