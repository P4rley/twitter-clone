//
//  ExploreView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 26/03/24.
//

import SwiftUI


struct ExploreView: View {
    @Binding var showMenu: Bool
    
    @State private var selectedFilter: ExploreTabModel.Tab = .trending
    @State private var mainViewScrollState: ExploreTabModel.Tab? = .trending
    @State private var tabBarScrollState: ExploreTabModel.Tab? = .trending
    
    @State private var tabs: [ExploreTabModel] = [
        .init(id: ExploreTabModel.Tab.trending),
        .init(id: ExploreTabModel.Tab.following),
        .init(id: ExploreTabModel.Tab.news),
        .init(id: ExploreTabModel.Tab.sports),
        .init(id: ExploreTabModel.Tab.entertaiment),
    ]
    
    var body: some View {
        NavigationStack {
            ExploreToolbar(showMenu: $showMenu, selectedFilter: $selectedFilter, mainViewScrollState: $mainViewScrollState, tabBarScrollState: $tabBarScrollState)
            
            GeometryReader {
                let size = $0.size
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(tabs) {explore in
                            ScrollView(.vertical, showsIndicators: false)  {
                                LazyVStack(pinnedViews: [.sectionHeaders]) {
                                    
                                    Section(header:
                                        HStack(alignment: .firstTextBaseline ) {
                                            Text("Trends for you")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .zIndex(1.0)
                                                .padding(.vertical, 10)
                                        
                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                        .background(Color.white)
                                            
                                    ) {
                                        ForEach(1...5, id: \.self) { count in
                                            ExploreCell()
                                            
                                            if count != 5 {
                                                Divider()
                                                
                                            }
                                            
                                        }
                                        
                                        
                                        Button {
                                            
                                        } label: {
                                            HStack {
                                                Text("Show more")
                                                    .foregroundStyle(.link)
                                                
                                                Spacer()
                                                
                                                Image(systemName: "chevron.right")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 14, height: 14)
                                                    .foregroundStyle(Color(.systemGray4))
                                            }
                                            .padding(.horizontal)
                                            .padding(.top, 5)
                                        }
                                        
                                        Divider()
                                        
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("Videos for you")
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                    .zIndex(1.0)
                                                    .padding(.top, 10)
                                                
                                                
                                                Spacer()
                                            }
                                            
                                                                        
                                            
                                            Text("Check out these popular and trending video for you")
                                                .font(.footnote)
                                                .foregroundStyle(Color(.gray))
                                            
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(alignment: .firstTextBaseline, spacing: 10) {
                                                    ForEach(0...10, id: \.self) { _ in
                                                        Button {
                                                            
                                                        } label: {
                                                            Image("sample-image")
                                                                .resizable()
                                                                .scaledToFill()
                                                                .frame(width: 140, height: 180)
                                                                .cornerRadius(10)
                                                                .overlay(
                                                                    Image(systemName: "arrowtriangle.forward.fill")
                                                                        .font(.title2)
                                                                        .fontWeight(.ultraLight)
                                                                        .foregroundStyle(.white)
                                                                        .padding(15)
                                                                        .background(
                                                                            Circle()
                                                                                .fill(Color.black.opacity(0.35))
                                                                        )
                                                                    
                                                                )

                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                        .background(Color.white)
                                    }
                                }
                                .frame(width: size.width)
                            }
                            .refreshable {
                                print("DEBUG: REFRESH")
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
            }
            
        }
    }
}

struct ExploreToolbar: View {
    
    @Namespace var animation
    @Binding var showMenu: Bool
    @Binding var selectedFilter: ExploreTabModel.Tab
    @Binding var mainViewScrollState: ExploreTabModel.Tab?
    @Binding var tabBarScrollState: ExploreTabModel.Tab?
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ExploreTabModel.Tab.allCases.count)
        
        return UIScreen.main.bounds.width / count - 30
    }
    
    @State private var tabs: [ExploreTabModel] = [
        .init(id: ExploreTabModel.Tab.trending),
        .init(id: ExploreTabModel.Tab.following),
        .init(id: ExploreTabModel.Tab.news),
        .init(id: ExploreTabModel.Tab.sports),
        .init(id: ExploreTabModel.Tab.entertaiment),
    ]
    
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button {
                    withAnimation {
                        showMenu.toggle()
                    }
                } label: {
                    CircularImageView(size: .xSmall)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    
                } label: {
                    NavigationLink(destination: ExploreSearchView()) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(.systemGray5))
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                HStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(Color(.darkGray))
                                    
                                    Text("Search")
                                        .foregroundStyle(Color(.darkGray))
                                }
                            )
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // Action
                }) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.black)
                }
                .padding(.horizontal)
            }
            
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: filterBarWidth) {
                        ForEach(tabs) { explore in
                            VStack {
                                Text(explore.id.rawValue)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(.black))
                                    .opacity(selectedFilter == explore.id ? 1 : 0.5)
                                
                                if selectedFilter == explore.id {
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
                                withAnimation(.snappy(duration: 0.3)) {
                                    mainViewScrollState = explore.id
                                    tabBarScrollState = explore.id
                                    selectedFilter = explore.id
                                    scrollView.scrollTo(explore.id, anchor: .center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .scrollPosition(id: .init(get: {
                    return tabBarScrollState
                }, set: { _ in
                }), anchor: .center)
            }
            
        }
        .overlay (
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 1)
                .foregroundStyle(Color(.systemGray4)),
            alignment: .bottom
        )
        .background(Color.white, ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    ExploreView(showMenu: .constant(false))
}

