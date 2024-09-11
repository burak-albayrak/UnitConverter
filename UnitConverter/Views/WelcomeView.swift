//
//  WelcomeView.swift
//  UnitConverter
//
//  Created by Burak Albayrak on 10.09.2024.
//

import SwiftUI

struct WelcomeView: View {
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
            imageName: "square.grid.2x2",
            isSymbol: true
        ),
        WelcomePage(
            titleKey: "FavoritesTitle",
            descriptionKey: "FavoritesDescription",
            imageName: "star.circle",
            isSymbol: true
        ),
        WelcomePage(
            titleKey: "GetStartedTitle",
            descriptionKey: "GetStartedDescription",
            imageName: "arrow.right.circle",
            isSymbol: true
        )
    ]
    
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        VStack {
                            Group {
                                if pages[index].isSymbol {
                                    Image(systemName: pages[index].imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.cyan)
                                } else {
                                    Image(pages[index].imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                }
                            }
                            .scaleEffect(currentPage == index ? 1 : imageScale)
                            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: currentPage)
                            
                            Text(pages[index].titleKey)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding()
                                .opacity(currentPage == index ? 1 : textOpacity)
                                .animation(.easeIn(duration: 0.5), value: currentPage)
                            
                            Text(pages[index].descriptionKey)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding()
                                .opacity(currentPage == index ? 1 : textOpacity)
                                .animation(.easeIn(duration: 0.5), value: currentPage)
                        }
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
                        .background(Color.cyan)
                        .cornerRadius(10)
                }
                .padding()
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
        control.currentPageIndicatorTintColor = UIColor(Color.customCyan)
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
            WelcomeView(showWelcomeScreen: $showWelcomeScreen)
        }
    }
    
    return PreviewWrapper()
}
