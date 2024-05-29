//
//  ProfileView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 07/05/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    
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
    
    @State private var offset: CGFloat = 0
    @State private var currentTab: String = "Posts"
    @State private var tabBarOffset: CGFloat = 0
    @State private var titleOffset: CGFloat = 0
    
    @StateObject var viewModel = ProfileViewModel()
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileTabModel.Tab.allCases.count)
        
        return UIScreen.main.bounds.width / count - 30
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                HStack(spacing: 0) {
                    Button {
                        dismiss()
                    } label: {
                        ImageOnCircle(image: "arrow.left")
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 5) {
                        HStack (alignment: .center, spacing: 10) {
                            Button {
                                dismiss()
                            } label: {
                                ImageOnCircle(image: "magnifyingglass")
                            }
                            
                            Button {
                                dismiss()
                            } label: {
                                ImageOnCircle(image: "ellipsis")
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .zIndex(3)
                .background(Color.clear)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        GeometryReader { proxy -> AnyView in
                            
                            let minY = proxy.frame(in: .global).minY
                            
                            DispatchQueue.main.async {
                                self.offset = minY
                            }
                            
                            return AnyView (
                                ZStack() {
                                    
                                    Image("banner-image")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: self.getRect().width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                                    
                                    BlurView()
                                        .opacity(BlurViewOpacity())
                                    
                                    
                                    
                                    VStack(spacing: 5 ) {
                                        Text(currentUser?.username ?? "")
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                        
                                        Text("100 Tweets")
                                            .foregroundStyle(.white)
                                    }
                                    .padding(.horizontal)
                                    .offset(y: 120)
                                    .offset(y: titleOffset > 100 ? 0 : -getTitleTextOffset())
                                    .opacity(titleOffset < 120 ? 1 : 0)
                                }
                                .frame(height: minY > 0 ? 180 + minY : nil)
                                .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                            )
                        }
                        .frame(height: 180)
                        .zIndex(1)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                CircularImageView(size: .xLarge)
                                    .padding(8)
                                    .background(colorScheme == .dark ? Color.black : Color.white)
                                    .clipShape(Circle())
                                    .offset(y: offset < 0 ? getOffset() - 20 : -20)
                                    .scaleEffect(getScale())
                                
                                Spacer()
                                
                                Button {
                                    
                                } label: {
                                    Text("Edit Profile")
                                        .foregroundStyle(.blue)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(
                                            Capsule()
                                                .stroke(Color.blue, lineWidth: 1.5)
                                        )
                                }
                            }
                            .padding(.top, -25)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(currentUser?.fullname ?? "")
                                    .fontWeight(.bold)
                                    .font(.system(size: 24))
                                
                                Text(currentUser?.username ?? "")
                                    .foregroundStyle(Color(.gray))
                                
                                Text(currentUser?.bio ?? "")
                                
                                HStack {
                                    Button {
                                        
                                    } label: {
                                        Label {
                                            Text("Following")
                                                .foregroundStyle(Color(.gray))
                                        } icon: {
                                            Text("100k")
                                                .foregroundStyle(.black)
                                                .fontWeight(.medium)
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
                                                .fontWeight(.medium)
                                        }
                                        
                                    }
                                }
                                .padding(.top, 8)
                                
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

                                
                                ForEach(0...10, id: \.self) { _ in
                                    FeedCell()
                                }
                            }
                            .overlay (
                                GeometryReader { proxy -> Color in
                                    let minY = proxy.frame(in: .global).minY
                                    
                                    DispatchQueue.main.async {
                                        self.titleOffset = minY
                                    }
                                    
                                    return Color.clear
                                }
                            )
                        }
                        .padding(.horizontal)
                        .zIndex(-offset > 80 ? 0 : 1 )
                    }
                    
                }
                .refreshable {
                    print("DEBUG: REFRESH PROFILE VIEW")
                }
                .ignoresSafeArea(.all, edges: .top)
                .navigationTitle("")
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    func getOffset () -> CGFloat {
        let progress = (-offset / 80) * 20
        
        return progress <= 20 ? progress : 20
    }
    
    func getScale () -> CGFloat {
        let progress = -offset / 80
        
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        
        return scale < 1 ? scale : 1
    }
    
    func BlurViewOpacity () -> Double {
        let progress = -(offset + 80) / 150
        
        return Double(-offset > 80 ? progress : 0)
    }
    
    func getTitleTextOffset () -> CGFloat {
        let progress = 20 / titleOffset
        
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        
        return offset
        
    }
    
    @ViewBuilder
    func ImageOnCircle(image: String) -> some View {
        Circle()
            .fill(Color.black.opacity(0.3))
            .overlay(GeometryReader {
                let side = sqrt($0.size.width * $0.size.width / 2)
                
                VStack {
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: side, height: side)
                        .overlay(
                            Image(systemName: image)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.white)
                                .padding(2)
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
            .frame(width: 30, height: 30)
    }
}

#Preview {
    ProfileView()
}

struct TabButton: View {
    
    var title: String
    var animation: Namespace.ID
    @Binding var currentTab: String
    
    var body: some View {
        Button {
            withAnimation {
                currentTab = title
            }
        } label: {
            LazyVStack(spacing: 12) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundStyle(currentTab == title ? .blue : .gray)
                    .padding(.horizontal)
                
                if currentTab == title {
                    Capsule()
                        .fill(.blue)
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                } else {
                    Capsule()
                        .fill(Color.clear)
                        .frame(height: 2)
                }
            }
        }
        .buttonStyle(NoTapAnimation())
    }
}



