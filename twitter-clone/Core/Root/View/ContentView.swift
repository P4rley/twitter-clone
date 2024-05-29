//
//  ContentView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 20/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                SidebarView()
            } else {
                HomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
