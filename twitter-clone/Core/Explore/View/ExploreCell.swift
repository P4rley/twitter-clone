//
//  ExploreCell.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 24/04/24.
//

import SwiftUI

struct ExploreCell: View {
    var body: some View {
        
        Button {
            
        } label: {
            VStack(alignment: .leading) {
                Text("John Doe")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.black)
                
                Text("99.9K posts")
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundStyle(Color.gray)
                    .padding(.vertical, 1)
                
                HStack {
                    Text("Trending in Indonesia")
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                        .foregroundStyle(Color(.darkGray))
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(Color(.systemGray4))
                }
                
                
                
            }
            .padding()
        }
    }
}

#Preview {
    ExploreCell()
}
