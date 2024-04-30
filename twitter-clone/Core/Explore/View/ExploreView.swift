//
//  ExploreView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 26/03/24.
//

import SwiftUI


struct ExploreView: View {
    @Binding var showMenu: Bool
    var body: some View {
        NavigationStack {
            ExploreToolbar(showMenu: $showMenu)
            
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
            }
            .refreshable {
                print("DEBUG: REFRESH")
            }
        }
    }
}

struct ExploreToolbar: View {
    @State private var selectedFilter: ExploreFilter = .forYou
    @Namespace var animation
    @Binding var showMenu: Bool
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(FeedFilter.allCases.count)
        
        return UIScreen.main.bounds.width / count - 170
    }
    
    
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
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray4))
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
                        ForEach(ExploreFilter.allCases) { explore in
                            VStack {
                                Text(explore.title)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(.black))
                                    .opacity(selectedFilter == explore ? 1 : 0.5)
                                    .id(explore.title)
                                
                                if selectedFilter == explore {
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
                                withAnimation(.linear(duration: 0.3)) {
                                    selectedFilter = explore
                                    scrollView.scrollTo(explore.title, anchor: .center)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
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

