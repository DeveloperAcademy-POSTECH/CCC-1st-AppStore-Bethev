//
//  ContentView.swift
//  AppStoreClone
//
//  Created by leejunmo on 2022/06/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var controller: Controller
    @Namespace var animation
    
    var body: some View {
        ZStack {
            TabView {
                TodayView(animationId: animation)
                    .environmentObject(controller)
                    .tabItem({
                        Image(systemName: "doc.text.image")
                        Text("투데이")
                    })
                Text("게임")
                    .tabItem({
                        Image(systemName: "gamecontroller")
                        Text("게임")
                    })
                AppView()
                    .tabItem({
                        Image(systemName: "square.stack.3d.up.fill")
                        Text("앱")
                    })
                Text("Arcade")
                    .tabItem({
                        Image(systemName: "circle.grid.cross")
                        Text("Arcade")
                    })
                Text("검색")
                    .tabItem({
                        Image(systemName: "magnifyingglass")
                        Text("검색")
                    })
                
            }
            if controller.showCardView {
                switch controller.selectedCard {
                case "title":
                    DetailView(namespace: animation, show: $controller.showCardView)
                        .environmentObject(controller)
                case "list":
                    DetailView(namespace: animation, show: $controller.showCardView)
                        .environmentObject(controller)
                default:
                    EmptyView()
                }
            }
        }
        .statusBar(hidden: controller.showCardView)
    }
}

//
//  P162_ScreenTransition.swift
//  Fabula
//
//  Created by jasu on 2021/09/06.
//  Copyright (c) 2021 jasu All rights reserved.
//

extension Animation {
    static var transitionSpring: Animation {
       self.spring(response: 0.48, dampingFraction: 0.82, blendDuration: 0.7)
    }
}

// MARK: DetailView
extension ContentView {
    struct DetailView: View {
        @EnvironmentObject var controller: Controller
        
        let namespace: Namespace.ID
        @Binding var show: Bool
        @State private var showText: Bool = false
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack {
                        NamespaceView(namespace: namespace)
                            .frame(height: 460)
                        
                        ZStack {
                            Color.black
                            if showText {
                                Text("The formalism used the concepts of fabula and syuzhet as a way to develop narrative construction or classified materials and compositions into fabula and syuzhet, respectively. The totality of microscopic events listed in causality was called a fabula, and the narrative arrangement of these motifs in an artistic way was called a syuzhet. This app is a personal project to learn the technical ingredients of SwiftUI and derive creative results. SwiftUI is a user interface toolkit that can develop applications in a declarative manner. This is a modern development method that communicates to iOS how you want the user interface to behave and finds out how users perform when interacting with the interface. In addition, SwiftUI can develop macOS, watchOS, and tvOS with the same code as well as iOS development. The most appealing thing for me personally is that it is easy to learn and that the code is concise, making it easy for beginners to understand. I hope this project will help everyone, including myself, to understand SwiftUI. The code of this project will be updated regularly.")
                                    .lineLimit(nil)
                                    .padding(12)
                            }
                        }
                        .animation(.transitionSpring, value: showText)
                        .onAppear {
                            DispatchQueue.main.async {
                                withAnimation(.easeInOut) {
                                    showText = true
                                }
                            }
                        }
                    }
                }
                Image(systemName: "xmark")
                    .padding(8)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.16), radius: 3, x: 0, y: 0)
                    .padding()
                    .onTapGesture {
                        withAnimation(.transitionSpring) {
                            show = false
                        }
                    }
            }
        }
    }
}

// MARK: NamespaceView
extension ContentView {
    struct NamespaceView: View {
        @EnvironmentObject var controller: Controller
        
        let namespace: Namespace.ID
        
        var imageTitleView: some View {
            ZStack(alignment: .bottomLeading) {
                ZStack {
                    Color.gray
                }
                .clipShape(Rectangle())
                .matchedGeometryEffect(id: "image\(controller.selectedCardId)", in: namespace)
                
                VStack(alignment: .leading, spacing: -6) {
                    let arrText = controller.selectedCardId.split(separator: "\n")
                    ForEach(arrText, id: \.self) { text in
                        Text(text)
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(Color.white)
                    }
                }
                .shadow(color: Color.black.opacity(0.16), radius: 3, x: 0, y: 0)
                .padding()
                .padding(.bottom, 56)
                .matchedGeometryEffect(id: "title\(controller.selectedCardId)", in: namespace)
            }
        }
        
        var bottomInfoView: some View {
            ZStack(alignment: .leading) {
                if #available(macOS 12.0, *) {
                    Rectangle()
                        .fill(.thinMaterial)
                } else {
                    Rectangle()
                        .fill(Color.black.opacity(0.5))
                }
                HStack(spacing: 0) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .padding(11)
                    VStack(alignment: .leading) {
                        Text(controller.selectedCardId)
                            .bold()
                        Text(controller.selectedCardId)
                            .font(.caption)
                            .opacity(0.8)
                    }.offset(y: -2)
                    Spacer()
                    Capsule()
                        .fill(Color.white)
                        .overlay(
                            Text("GET")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.blue)
                        )
                        .frame(width: 70, height: 28)
                        .padding(.trailing)
                }
                .padding(.leading, 6)
            }
            .frame(maxHeight: 61)
            .matchedGeometryEffect(id: "botttom\(controller.selectedCardId)", in: namespace)
        }
        
        var body: some View {
            ZStack(alignment: .bottom) {
                imageTitleView
                bottomInfoView
            }
        }
    }
}
