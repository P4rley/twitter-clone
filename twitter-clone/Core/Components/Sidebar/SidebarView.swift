//
//  SidebarView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 30/04/24.
//

import SwiftUI

struct SidebarView: View {
   
    @State var showMenu: Bool = false
    @State var currentTab = 0
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    @State var selectedTab = 0
    @State private var rotationAngle: Double = 0
    @State private var scale: CGFloat = 1
    @State private var opacity: CGFloat = 1
    @State private var showCreateTweetScreen: Bool = false
    
    @GestureState var gestureOffset: CGFloat = 0
    
    @Namespace var animation
    
    var body: some View {
        let sideBarWidth = self.getRect().width - 90
        
        NavigationStack {
            HStack(spacing: 0) {
                SideMenu(showMenu: $showMenu)
                
                ZStack() {
                    TabBarView(selectedTab: $selectedTab, showMenu: $showMenu)
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                showCreateTweetScreen.toggle()
                            } label: {
                                if selectedTab == 4 {
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(Color.blue)
                                        .overlay(
                                            Image(systemName:  "plus.bubble.fill")
                                                .font(.system(size: 20))
                                                .scaledToFit()
                                                .foregroundStyle(Color.white)
                                            
                                        )
                                        .opacity(opacity)
                                        .rotationEffect(.degrees(rotationAngle))
                                        .scaleEffect(scale)
                                        .onAppear{
                                            scale = 0.8
                                            rotationAngle = -60
                                            opacity = 0.5
                                            withAnimation(.bouncy) {
                                                scale = 1
                                                opacity = 1
                                                rotationAngle = 0
                                            }
                                            
                                        }
                                } else {
                                    Circle()
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(Color.blue)
                                        .overlay(
                                            Image(systemName:  "plus")
                                                .font(.system(size: 20))
                                                .scaledToFit()
                                                .foregroundStyle(Color.white)
                                            
                                        )
                                        .opacity(opacity)
                                        .rotationEffect(.degrees(rotationAngle))
                                        .scaleEffect(scale)
                                        .onAppear{
                                            scale = 0.8
                                            rotationAngle = 60
                                            opacity = 0.5
                                            withAnimation(.bouncy) {
                                                opacity = 1
                                                scale = 1
                                                rotationAngle = 0
                                            }
                                            
                                        }
                                }
                            }
                        }
                    }
                    .fullScreenCover(
                        isPresented: $showCreateTweetScreen,
                        onDismiss: {
                            showCreateTweetScreen = false
                        },
                        content: {
                           CreateTweetView()
                    })
                    .padding(.horizontal)
                    .padding(.bottom, 60)

                }
                .frame(width: self.getRect().width)
                .overlay(
                    Rectangle()
                        .fill(
                            Color.primary.opacity(Double(offset / sideBarWidth) / 5)
                        )
                        .ignoresSafeArea(.container, edges: .vertical)
                        .onTapGesture {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }
                )
            }
            .frame(width: self.getRect().width + sideBarWidth)
            .offset(x: -sideBarWidth / 2)
            .offset(x: offset > 0 ? offset : 0)
            .gesture(
                DragGesture()
                    .updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded(onEnd(value:))
                
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity)
        }
        .animation(.easeOut, value: offset == 0)
        .onChange(of: showMenu) { newValue in

            if showMenu && offset == 0 {
                offset = sideBarWidth
                lastStoredOffset = offset
            }
            
            if !showMenu && offset == sideBarWidth {
                offset = 0
                lastStoredOffset = 0
            }
        }
        .onChange(of: gestureOffset) { newValue in
            onChange()
        }
        
    }
    
    func onChange() {
        let sideBarWidth = self.getRect().width - 90
        
        offset = (gestureOffset != 0) ? (gestureOffset < sideBarWidth ? gestureOffset + lastStoredOffset : offset) : offset
    }
    
    func onEnd(value: DragGesture.Value) {
        let sideBarWidth = self.getRect().width - 90
        
        let translation = value.translation.width
        
        withAnimation {
            if translation > 0 {
                if translation > (sideBarWidth / 2) {
                    offset = sideBarWidth
                    showMenu = true
                } else {
                    
                    if offset == sideBarWidth {
                        return
                    }
                    
                    offset = 0
                    showMenu = false
                }
            } else {
                if -translation > (sideBarWidth / 2) {
                    offset = 0
                    showMenu = false
                } else {
                    
                    if offset == 0 || !showMenu {
                        return
                    }
                    offset = sideBarWidth
                    showMenu = true
                }
            }
        }
        
        lastStoredOffset = offset
    }
    
    @ViewBuilder
    func TabButton(image: String, current: Int) -> some View {
        Button {
            withAnimation {
                currentTab = current
            }
        } label: {
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .frame(width: 22, height: 22)
                .foregroundStyle(currentTab == current ? .primary : Color.gray)
        }
    }
}

#Preview {
    SidebarView()
}
