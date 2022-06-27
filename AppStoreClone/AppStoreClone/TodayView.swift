//
//  TodayView.swift
//  AppStoreClone
//
//  Created by leejunmo on 2022/06/23.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var controller: Controller
    
    let animationId: Namespace.ID
    
    @State private var scrollViewContentOffset = CGFloat(0)
    var todayCardData: [[String: String]] = Data.todayCardData

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ScrollView {
                    HStack {
                        VStack {
                            Text("6월 28일 화요일")
                                .foregroundColor(.gray)
                                .font(.footnote)
                            Text("투데이")
                                .fontWeight(.heavy)
                                .font(.largeTitle)
                        }
                        Spacer()
                        VStack {
                            Spacer().font(.footnote)
                            Button(action: {

                            }, label: {
                                Image(systemName: "person.crop.circle").font(.largeTitle)
                            }).padding(.top)
                        }
                    }.padding()
                    VStack {
                        ForEach(0..<todayCardData.count, id: \.self) { idx in
                            CardView(cardData: todayCardData[idx])
                                .environmentObject(controller)
                                .matchedGeometryEffect(id: "image\(todayCardData[idx]["title"]!)", in: animationId)
                        }
                    }
                }
                VStack {
                    Color.status.opacity(0.98)
                        .frame(height: geo.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

// MARK: TodayButtonStyle
extension TodayView {
    struct TodayButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .scaleEffect(configuration.isPressed ? 0.965:1)
        }
    }
}

// MARK: CardView
extension TodayView {
    struct CardView: View {
        @EnvironmentObject var controller: Controller
        
        let cardData: [String: String]
        
        var body: some View {
            switch cardData["type"] {
            case "topTitleOnImage":
                TopTitleOnImageView(title: cardData["title"]!,
                                    subTitle: cardData["subTitle"],
                                    imageName: cardData["imageName"])
                .environmentObject(controller)
            case "bottomTitleOnImage":
                BottomTitleOnImageView(title: cardData["title"]!,
                                       subTitleTop: cardData["subTitleTop"],
                                       subTitleBottom: cardData["subTitleBottom"],
                                       imageName: cardData["imageName"])
                .environmentObject(controller)
            case "topTitleList":
                TopTitleListView()
            default:
                EmptyView()
            }
        }
    }
}

// MARK: TopTitleOnImageView
extension TodayView {
    struct TopTitleOnImageView: View {
        @EnvironmentObject var controller: Controller
        
        let title: String
        let subTitle: String?
        let imageName: String?
        
        @State private var isTouch: Bool = false
        
        var body: some View {
            Button(action: {
                withAnimation(.transitionSpring) {
                    controller.showCardView.toggle()
                    controller.selectedCard = "title"
                    controller.selectedCardId = title
                }
            }, label: {
                ZStack(alignment: .leading) {
                    // 이미지 대신 컬러로 적용
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(.brown)
                        .frame(height: 450)
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            if let subTitle = subTitle {
                                Text(subTitle).font(.subheadline).foregroundColor(.secondary)
                            }
                            Text(title)
                                .fontWeight(.bold)
                                .font(.title)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                    }
                }.padding([.bottom, .horizontal])
            })
            .buttonStyle(TodayButtonStyle())
        }
    }
}

// MARK: BottomTitleOnImageView
extension TodayView {
    struct BottomTitleOnImageView: View {
        @EnvironmentObject var controller: Controller
        
        let title: String
        let subTitleTop: String?
        let subTitleBottom: String?
        let imageName: String?
        
        var body: some View {
            Button(action: {
                withAnimation(.transitionSpring) {
                    controller.showCardView.toggle()
                    controller.selectedCard = "title"
                    controller.selectedCardId = title
                }
            }, label: {
                ZStack(alignment: .leading) {
                    // 이미지 대신 컬러로 적용
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(.purple)
                        .frame(height: 450)
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Spacer()
                            if let subTitleTop = subTitleTop, let subTitleBottom = subTitleBottom {
                                Text(subTitleTop).font(.subheadline)
                                Text(title).fontWeight(.bold).font(.title2)
                                Text(subTitleBottom).font(.subheadline)
                            } else {
                                Text(title)
                                    .fontWeight(.bold)
                                    .font(.title)
                            }
                        }.padding()
                    }
                }
                .padding([.bottom, .horizontal])
            })
            .buttonStyle(TodayButtonStyle())
        }
    }
}

// MARK: TopTitleListView
extension TodayView {
    struct TopTitleListView: View {
        var body: some View {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}
