//
//  MessagesView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 26/03/24.
//

import SwiftUI

struct MessagesView: View {
    
    @State private var isActived: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                MessageToolbar()
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack() {
                        ForEach(0...10, id: \.self) { _ in
                            NavigationLink(destination: ProfileView()) {
                                MessagesCell()
                                    .padding(.horizontal)
                                    .padding(.bottom, 15)
                            }
                        }
                    }
                }
                .refreshable {
                    print("DEBUG: Refresh Messages")
                }
                Spacer()
            }
            
        }
    }
}

#Preview {
    MessagesView()
}

struct MessageToolbar: View {
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button {
                    
                } label: {
                    CircularImageView(size: .xSmall)
                }
                
                Spacer()
                
                Text("Messages")
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundStyle(.black)
                }
            }
            
            Button {
                
            } label: {
                HStack(alignment: .center) {
                    Image(systemName: "magnifyingglass")
                    
                    Text("Search Direcct Messages")
                }
                .frame(maxWidth: .infinity)
                
                    .foregroundStyle(Color(.systemGray6))
                    .padding(.vertical, 12)
                    .font(.system(size: 20))
                    .padding(.horizontal)
                .background(
                    Capsule()
                        .foregroundStyle(Color(.systemGray4))
                )
            }

        }
        .padding(.horizontal)
        
        Divider()
            .padding(.vertical, 5)
    }
}
