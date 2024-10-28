//
//  WelcomeViewIPad.swift
//  UnitConverterIPad
//
//  Created by Burak Albayrak on 21.10.2024.
//

import SwiftUI

struct WelcomeViewIPad: View {
    @State private var currentPage = 0
    @Binding var showWelcomeScreen: Bool
    @State private var imageScale: CGFloat = 0.5
    @State private var textOpacity: Double = 0
    @Environment(\.horizontalSizeClass) var sizeClass
    
    let pages: [WelcomePage] = [
        WelcomePage(
            titleKey: "WelcomeTitle",
            descriptionKey: "WelcomeDescription",
            imageName: "Logo",
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
        GeometryReader { geometry in
            ZStack {
                Color.accentColor.opacity(0.1).edgesIgnoringSafeArea(.all)
                
                VStack {
                    TabView(selection: $currentPage) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            welcomePageView(for: pages[index], geometry: geometry)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .overlay(
                        CustomPageControl(numberOfPages: pages.count, currentPage: currentPage)
                            .padding(.bottom)
                        , alignment: .bottom
                    )
                    .onChange(of: currentPage) { _, _ in
                        withAnimation {
                            imageScale = 0.5
                            textOpacity = 0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeIn(duration: 0.5)) {
                                imageScale = 1.0
                                textOpacity = 1
                            }
                        }
                    }
                    
                    nextButton
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeIn(duration: 0.5)) {
                    imageScale = 1.0
                    textOpacity = 1
                }
            }
        }
    }
    
    @ViewBuilder
    private func welcomePageView(for page: WelcomePage, geometry: GeometryProxy) -> some View {
        if sizeClass == .regular {
            // iPad layout
            HStack(spacing: 25) {
                pageImage(for: page)
                    .frame(width: geometry.size.width * 0.25)
                    .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    pageTitle(for: page)
                    pageDescription(for: page)
                }
                .frame(width: geometry.size.width * 0.5)
            }
        } else {
            // iPhone layout
            VStack {
                pageImage(for: page)
                    .frame(height: geometry.size.height * 0.3)
                pageTitle(for: page)
                pageDescription(for: page)
            }
        }
    }
    
    private func pageImage(for page: WelcomePage) -> some View {
        Group {
            if page.isSymbol {
                Image(systemName: page.imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.accentColor)
            } else {
                Image(page.imageName)
                    .resizable()
                    .scaledToFit()
            }
        }
        .scaleEffect(currentPage == pages.firstIndex(where: { $0.titleKey == page.titleKey }) ?? 0 ? 1 : imageScale)
        .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: currentPage)
    }
    
    private func pageTitle(for page: WelcomePage) -> some View {
        Text(page.titleKey)
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .padding()
            .opacity(currentPage == pages.firstIndex(where: { $0.titleKey == page.titleKey }) ?? 0 ? 1 : textOpacity)
            .animation(.easeIn(duration: 0.5), value: currentPage)
    }
    
    private func pageDescription(for page: WelcomePage) -> some View {
        Text(page.descriptionKey)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding()
            .opacity(currentPage == pages.firstIndex(where: { $0.titleKey == page.titleKey }) ?? 0 ? 1 : textOpacity)
            .animation(.easeIn(duration: 0.5), value: currentPage)
    }
    
    private var nextButton: some View {
        Button(action: {
            if currentPage < pages.count - 1 {
                withAnimation {
                    currentPage += 1
                }
            } else {
                showWelcomeScreen = false
            }
        }) {
            Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.accentColor)
                .cornerRadius(10)
        }
        .padding()
    }
}

struct WelcomePage {
    let titleKey: LocalizedStringKey
    let descriptionKey: LocalizedStringKey
    let imageName: String
    let isSymbol: Bool
}

struct CustomPageControl: UIViewRepresentable {
    var numberOfPages: Int
    var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPage = currentPage
        control.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
        control.currentPageIndicatorTintColor = UIColor(Color.accentColor)
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var showWelcomeScreen = true
        
        var body: some View {
            WelcomeViewIPad(showWelcomeScreen: $showWelcomeScreen)
        }
    }
    
    return PreviewWrapper()
}
