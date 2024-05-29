//
//  CreateTweetView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 21/05/24.
//

import SwiftUI

struct CreateTweetView: View {
    @State private var text: String = ""
    @Environment(\.dismiss) var dismiss
    
    let icons = [
        IconsList(name: "photo"),
        IconsList(name: "checklist"),
        IconsList(name: "mappin.and.ellipse"),
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        HStack(alignment: .top, spacing: 5) {
                            CircularImageView(size: .small)
                            
                            TextAreaField("What's happening?", text: $text)
                                .background(.red)
                        }
                    }
                    .padding(.vertical)
                    
                }
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(alignment: .bottom, spacing: 25) {
                            ForEach(icons, id: \.id) { icon in
                                Button {
                                    
                                } label: {
                                    Image(systemName: icon.name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(Color.blue)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.blue)
                    }
                }
                .padding(.vertical)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 18))
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Post")
                            .foregroundStyle(Color(.white))
                            .fontWeight(.semibold)
                            .padding(.vertical, 9)
                            .padding(.horizontal)
                            .background(
                                Capsule()
                                    .foregroundStyle(Color.blue)
                            )
                    }
                    .opacity(text.isEmpty ? 0.5 : 1)
                    .disabled(text.isEmpty)
                }
            }
            .padding(.horizontal)
        }
        
    }
}

struct IconsList: Identifiable {
    var id = UUID()
    var name: String
}

#Preview {
    CreateTweetView()
}
