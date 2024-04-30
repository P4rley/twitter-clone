//
//  TabView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 26/03/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @Binding var showMenu: Bool
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                FeedView(showMenu: $showMenu)
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                            .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    }
                    .onAppear { selectedTab = 0 }
                    .tag(0)
                
                ExploreView(showMenu: $showMenu)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .onAppear { selectedTab = 1 }
                    .tag(1)
                
                CommunitiesView()
                    .tabItem {
                        Image(systemName: selectedTab == 2 ? "person.2.fill" : "person.2")
                            .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    }
                    .onAppear { selectedTab = 2 }
                    .tag(2)
                
                NotificationsView()
                    .tabItem {
                        Image(systemName: selectedTab == 3 ? "bell.fill" : "bell")
                            .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                    }
                    .onAppear { selectedTab = 3 }
                    .tag(3)
                
                MessagesView()
                    .tabItem {
                        Image(systemName: selectedTab == 4 ? "envelope.fill" : "envelope")
                            .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                    }
                    .onAppear { selectedTab = 4 }
                    .tag(4)
            }
        }
        .tint(.black)
    }
}

#Preview {
    TabBarView(showMenu: .constant(false))
}
