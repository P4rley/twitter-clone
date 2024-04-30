//
//  FeedView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 26/03/24.


import SwiftUI

struct FeedView: View {
    
    @Namespace var animation
    
    @State private var scrollViewOffset: CGFloat = 0
    @State private var isToolbarHidden = false
    @State private var tabState: Visibility = .visible
    @State private var opacity: Double = 0.0
    @State var hideNavigationBar: Bool = false
    
    @StateObject var headerData = HeaderViewModel()
    
    @Binding var showMenu: Bool
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {

                Toolbar(showMenu: $showMenu)
                    .offset(y: tabState == .visible ? 0 : -200)
                    .animation(.easeInOut(duration: 0.3), value: tabState)
                    .zIndex(1)
                    
                
                ToolbarScrollView(axis: .vertical, showIndicator: true, tabState: $tabState) {
                    LazyVStack {
                        ForEach(0...10, id: \.self) { _ in
                            FeedCell()
                        }
                    }
                }
                .padding(.top, tabState == .visible ? 75 : 0)
                .animation(.easeInOut(duration: 0.3), value: tabState)
                .refreshable {
                    print("DEBUG: REFRESH")
                }
            }
        }
       
    }
    
}


#Preview {
    FeedView(showMenu: .constant(false))
}

struct Toolbar: View {
    @State private var selectedFilter: FeedFilter = .forYou
    @Namespace var animation
    @State private var scrollOffset: CGFloat = 0
    @Binding var showMenu: Bool
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(FeedFilter.allCases.count)
        
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
                ForEach(FeedFilter.allCases) { filter in
                    
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.black))
                            .opacity(selectedFilter == filter ? 1 : 0.5)
                        
                        if selectedFilter == filter {
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
                        withAnimation(.linear(duration: 0.3)) {
                            selectedFilter = filter
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


