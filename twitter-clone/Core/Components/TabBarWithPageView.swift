//
//  SwiftUIView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 14/05/24.
//

import SwiftUI

struct TabBarWithPageView: View {
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileTabModel.Tab.allCases.count)
        
        return UIScreen.main.bounds.width / count - 30
    }
    
    @State private var selectedFilter: ProfileTabModel.Tab = .posts
    @State private var mainViewScrollState: ProfileTabModel.Tab? = .posts
    @State private var tabBarScrollState: ProfileTabModel.Tab? = .posts
    @State private var tabs: [ProfileTabModel] = [
        .init(id: ProfileTabModel.Tab.posts),
        .init(id: ProfileTabModel.Tab.replies),
        .init(id: ProfileTabModel.Tab.highlights),
        .init(id: ProfileTabModel.Tab.articles),
        .init(id: ProfileTabModel.Tab.media),
        .init(id: ProfileTabModel.Tab.likes),
    ]
    
    @Namespace var animation
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {                   
                    HStack(alignment: .center, spacing: filterBarWidth) {
                    ForEach(tabs) { profile in
                        VStack {
                            Text(profile.id.rawValue)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color(.black))
                                .opacity(selectedFilter == profile.id ? 1 : 0.5)
                                .id(profile.id)
                            
                            if selectedFilter == profile.id {
                                Rectangle()
                                    .foregroundStyle(Color(.black))
                                    .frame(height: 3)
                                    .matchedGeometryEffect(id: "item", in: animation)
                            } else {
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .frame(height: 3)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selectedFilter = profile.id
                                mainViewScrollState = profile.id
                                tabBarScrollState = profile.id
                                scrollView.scrollTo(profile.id, anchor: .center)
                            }
                        }
                    }
                }
                .zIndex(2)
                .padding(.horizontal)
                .padding(.top, 20)
                }
                .scrollPosition(id: .init(get: {
                    return tabBarScrollState
                }, set: { _ in
                }), anchor: .center)
            }
            .overlay (
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 1)
                    .foregroundStyle(Color(.systemGray4)),
                alignment: .bottom
            )
            
            
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        LazyHStack(spacing: 0) {
                            ForEach(tabs) {profile in
                                ScrollView(.vertical) {
                                    LazyVStack {
                                        ForEach(0...20, id: \.self) { _ in
                                            FeedCell()
                                                .frame(width: UIScreen.main.bounds.width)
                                        }
                                    }
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $mainViewScrollState)
                    .scrollTargetBehavior(.paging)
                    .onChange(of: mainViewScrollState, { oldValue, newValue in
                        if let newValue {
                            withAnimation(.snappy) {
                                tabBarScrollState = newValue
                                selectedFilter = newValue
                            }
                        }
                    })
                
            
            Spacer()
        }
    }
}

#Preview {
    TabBarWithPageView()
}
