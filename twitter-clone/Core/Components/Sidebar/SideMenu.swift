//
//  SideMenu.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 30/04/24.
//

import SwiftUI

struct SideMenu: View {
    @Binding var showMenu: Bool
    var body: some View {
            
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 15) {
                Image("sample-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                Text("JohnDoe")
                    .font(.title2.bold())
                
                Text("@JohnDoe1")
                    .font(.callout)
                
                HStack(spacing: 12) {
                    
                    Button {
                        
                    } label: {
                        Label {
                            Text("Followers")
                        } icon: {
                            Text("189")
                                .fontWeight(.bold)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Label {
                            Text("Following")
                        } icon: {
                            Text("189")
                                .fontWeight(.bold)
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
            .padding(.horizontal)
            .padding(.leading)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 45) {
                    TabButton(title: "Profile", image: "magnifyingglass")
                    
                    TabButton(title: "Home", image: "magnifyingglass")

                }
                .padding()
                .padding(.leading)
                .padding(.top, 35)
            }
            
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .background(
            Color.primary
                .opacity(0.04)
                .ignoresSafeArea(.container, edges: .vertical)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func TabButton(title: String, image: String) -> some View {
        Button {
            
        } label: {
            HStack(spacing: 14) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                
                Text(title)
            }
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    SidebarView()
}


extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
