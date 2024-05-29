//
//  FeedView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 26/03/24.


import SwiftUI

struct FeedView: View {
    
    @Namespace var animation
    @State private var selectedFilter: FeedTabModel.Tab = .forYou
    @State private var mainViewScrollState: FeedTabModel.Tab? = .forYou
    @State private var tabBarScrollState: FeedTabModel.Tab? = .forYou
    
    @State private var scrollViewOffset: CGFloat = 0
    @State private var isToolbarHidden = false
    @State private var tabState: Visibility = .visible
    @State private var opacity: Double = 0.0
    @State var hideNavigationBar: Bool = false
    
    @GestureState var gestureOffset: CGFloat = 0
    
    @StateObject var headerData = HeaderViewModel()
    
    @State private var tabs: [FeedTabModel] = [
        .init(id: FeedTabModel.Tab.forYou),
        .init(id: FeedTabModel.Tab.following),
    ]
    
    @Binding var showMenu: Bool
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                Toolbar(showMenu: $showMenu, selectedFilter: $selectedFilter, mainViewScrollState: $mainViewScrollState, tabBarScrollState: $tabBarScrollState)
                    .offset(y: tabState == .visible ? 0 : -200)
                    .animation(.easeInOut(duration: 0.3), value: tabState)
                    .zIndex(1)
                
//                ToolbarScrollView(axis: .vertical, showIndicator: true, tabState: $tabState) {
//                    ForEach(0...10, id: \.self) { _ in
//                        FeedCell()
//                    }
//                }
//                .padding(.top, tabState == .visible ? 75 : 0)
//                .animation(.easeInOut(duration: 0.3), value: tabState)
//                .refreshable {
//                    print("DEBUG: REFRESH")
//                }
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 0) {
                            ForEach(tabs) {profile in
                                ToolbarScrollView(axis: .vertical, showIndicator: true, tabState: $tabState) {
                                    ForEach(0...10, id: \.self) { _ in
                                        FeedCell()
                                            .frame(width: size.width)
                                    }
                                }                                
                                .padding(.top, tabState == .visible ? 75 : 0)
                                .animation(.easeInOut(duration: 0.3), value: tabState)
                                .refreshable {
                                    print("DEBUG: REFRESH")
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .padding(.top, tabState == .visible ? 55 : 0)
                    .ignoresSafeArea(.all)
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
}

#Preview {
    ContentView()
}

struct Toolbar: View {
    
    @Namespace var animation
    @State private var scrollOffset: CGFloat = 0
    @Binding var showMenu: Bool
    @Binding var selectedFilter: FeedTabModel.Tab
    @Binding var mainViewScrollState: FeedTabModel.Tab?
    @Binding var tabBarScrollState: FeedTabModel.Tab?
    
    @State private var tabs: [FeedTabModel] = [
        .init(id: FeedTabModel.Tab.forYou),
        .init(id: FeedTabModel.Tab.following),
    ]
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(FeedTabModel.Tab.allCases.count)
        
        return UIScreen.main.bounds.width / count - 50
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Action
                    withAnimation {
                        showMenu.toggle()
                    }
                }) {
                    CircularImageView(size: .xSmall)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Image("x-logo")
                    .resizable()
                    .frame(width: 28, height: 28)
                
                Spacer()
                
                Button(action: {
                    // Action
                }) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.black)
                }
                .padding(.horizontal)
            }
            .foregroundColor(.primary)
            
            HStack(alignment: .center, spacing: filterBarWidth) {
                ForEach(tabs) { filter in
                    
                    VStack {
                        Text(filter.id.rawValue)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.black))
                            .opacity(selectedFilter == filter.id ? 1 : 0.5)
                        
                        if selectedFilter == filter.id {
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
                    .fixedSize()
                    .onTapGesture {
                        withAnimation(.snappy(duration: 0.3)) {
                            selectedFilter = filter.id
                            mainViewScrollState = filter.id
                            tabBarScrollState = filter.id
                        }
                    }
                }
                .overlay (
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 1)
                        .foregroundStyle(Color(.systemGray4)),
                    alignment: .bottom
                )
            }
            
            
        }
        .background(Color.white, ignoresSafeAreaEdges: .all)


    }
}

struct ScrollViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}



