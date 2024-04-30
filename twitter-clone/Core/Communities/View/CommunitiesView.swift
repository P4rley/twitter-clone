//
//  CommunitiesView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 26/03/24.
//

import SwiftUI

struct CommunitiesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    HStack(alignment: .center) {
                        Text("Discover new Communities")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.vertical)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundStyle(Color(.systemGray4))
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 40) {
                        ForEach(1...3, id: \.self) { _ in
                            Button {
                                
                            } label: {
                                CommunitiesCell("Twitter Gaming")
                            }
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
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .navigationTitle("Communities")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            
                        } label: {
                            CircularImageView(size: .xSmall)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    CommunitiesView()
}
