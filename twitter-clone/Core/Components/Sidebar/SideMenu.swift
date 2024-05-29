//
//  SideMenu.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 30/04/24.
//

import SwiftUI

struct SideMenu: View {
    @Binding var showMenu: Bool
    @State private var isShowSettings: Bool = false
    @StateObject var viewModel = ProfileViewModel()
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Button {
                            showMenu = false
                        } label: {
                            NavigationLink(destination: ProfileView()) {
                                CircularImageView(size: .medium)
                            }
                        }
                        
                        Spacer()
                        
                        Image(systemName: "person.crop.circle.badge.plus")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text(currentUser?.fullname ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    
                    Text(currentUser?.username ?? "")
                        .foregroundStyle(Color(.gray))
                    
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Label {
                                Text("Following")
                                    .foregroundStyle(Color(.gray))
                            } icon: {
                                Text("57")
                                    .foregroundStyle(.black)
                            }
                            
                        }
                        
                        Button {
                            
                        } label: {
                            Label {
                                Text("Followers")
                                    .foregroundStyle(Color(.gray))
                            } icon: {
                                Text("100k")
                                    .foregroundStyle(.black)
                            }
                            
                        }
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 25) {
                        TabButton(title: "Profile", image: "person", size: 28, fontWeight: .bold, font: .title2)
                        
                        TabButton(title: "Bookmarks", image: "bookmark", size: 28, fontWeight: .bold, font: .title2)
                        
                        TabButton(title: "Lists", image: "list.bullet.rectangle.portrait", size: 28, fontWeight: .bold, font: .title2)
                        
                        TabButton(title: "Spaces", image: "mic", size: 28, fontWeight: .bold, font: .title2)
                        
                        Divider()
                            .padding(.vertical, 15)
                        
                        Button {
                            isShowSettings.toggle()
                        } label: {
                            HStack(alignment: .center) {
                                Text("Settings and Support")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .rotationEffect(isShowSettings ? .degrees(-180) : .degrees(0))
                                    .foregroundStyle(isShowSettings ? .blue : Color.black)
                                    .animation(.linear, value: isShowSettings)
                            }
                        }
                        .buttonStyle(NoTapAnimation())
                        .foregroundStyle(Color.black)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            TabButton(title: "Settings and privacy", image: "gearshape", size: 20, fontWeight: .regular, font: .subheadline)
                            
                            TabButton(title: "Help Center", image: "questionmark.circle", size: 20, fontWeight: .regular, font: .subheadline)
                            
                            Button {
                                Task {
                                    AuthService.shared.signOut()
                                }
                            } label: {
                                Text("Sign Out")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .background(Color.red)
                                    .cornerRadius(24)
                            }
                        }
                        .opacity(isShowSettings ? 1 : 0)
                        .animation(.linear, value: isShowSettings)
                    }
                }
                .padding(.top, 15)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(width: self.getRect().width - 90)
            .frame(maxHeight: .infinity)
            .background(
                Color.primary
                    .opacity(0.04)
                    .ignoresSafeArea(.container, edges: .vertical)
            )
            .frame(maxWidth: .infinity, alignment: .leading)

    }
    
    @ViewBuilder
    func TabButton(title: String, image: String, size: CGFloat, fontWeight: Font.Weight, font: Font) -> some View {
        Button {
            
        } label: {
            HStack(spacing: 14) {
                Image(systemName: image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                
                Text(title)
                    .fontWeight(fontWeight)
                    .font(font)
            }
            .foregroundStyle(Color.black)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(NoTapAnimation())
    }
}

#Preview {
        ContentView()
}

