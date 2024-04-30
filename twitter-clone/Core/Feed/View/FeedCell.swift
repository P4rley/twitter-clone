//
//  FeedCell.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 03/04/24.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                CircularImageView(size: .medium)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text("Name")
                        Text("@Username \u{2022} 17h")
                            .foregroundStyle(Color(.systemGray2))
                        
                        Spacer()
                        
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color(.systemGray2))
                    }
                    .foregroundStyle(Color(.black))
                    
                    Text("This is a caption")
                    
                    Image("sample-image")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 400, alignment: .leading)
                        .cornerRadius(10)
                    
                    HStack(alignment: .center, spacing: 19) {
                        
                        HStack(alignment: .center, spacing: 4) {
                            Image(systemName: "message")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                
                            Text("1,7k")
                                .font(.system(size: 12))
                        }
                        
                        HStack(alignment: .center, spacing: 4) {
                            Image(systemName: "arrow.2.squarepath")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                            Text("222")
                                .font(.system(size: 12))
                        }
                        
                        HStack(alignment: .center, spacing: 4) {
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                            Text("333")
                                .font(.system(size: 12))
                        }
                        
                        HStack(alignment: .center, spacing: 6) {
                            Image(systemName: "chart.bar.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                            Text("444")
                                .font(.system(size: 12))
                        }
                        
                        
                        HStack(alignment: .center, spacing: 5){
                            Image(systemName: "bookmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                            
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                        }
                        
                        
                    }
                    .padding(.top, 5)
                    .opacity(0.5)
                }
            }
            .padding()
            .overlay (
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 1)
                    .foregroundStyle(Color(.systemGray4)),
                alignment: .bottom
            )

        }
    }
}

#Preview {
    FeedCell()
}
