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
        WelcomePage(title: "Welcome to Unit Converter", description: "Convert units easily and quickly", imageName: "ruler"),
        WelcomePage(title: "Multiple Categories", description: "From length to radiation, we've got you covered", imageName: "list.bullet"),
        WelcomePage(title: "Save Favorites", description: "Keep your most used conversions handy", imageName: "star"),
        WelcomePage(title: "Get Started", description: "Start converting units now!", imageName: "arrow.right.circle")
    ]
    
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        VStack {
                            Image(systemName: pages[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.cyan)
                                .scaleEffect(currentPage == index ? 1 : imageScale)
                                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5), value: currentPage)
                            
                            Text(pages[index].title)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding()
                                .opacity(currentPage == index ? 1 : textOpacity)
                                .animation(.easeIn(duration: 0.5), value: currentPage)
                            
                            Text(pages[index].description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding()
                                .opacity(currentPage == index ? 1 : textOpacity)
                                .animation(.easeIn(duration: 0.5), value: currentPage)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
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
    let title: String
    let description: String
    let imageName: String
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
