//
//  CommunitiesCell.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 24/04/24.
//

import SwiftUI

struct CommunitiesCell: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image("sample-image")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .scaledToFill()
            
            VStack(alignment: .leading) {
                Text(truncateText(text))
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                Text("100K Members")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundStyle(Color(.gray))
                
                Text("Gaming")
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundStyle(Color(.gray))
                
                
                HStack {
                    ForEach(0...4, id: \.self) { index in
                        Image("sample-image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(lineWidth: 2).foregroundColor(Color.white))
                            .offset(x: CGFloat(-18 * index))
                            .zIndex(Double(0 - index))
                    }
                }
            }
            
            Spacer()
        }
    }
    
    func truncateText(_ text: String) -> String {
            if text.count > 25 {
                let truncatedIndex = text.index(text.startIndex, offsetBy: 25)
                return String(text.prefix(upTo: truncatedIndex)) + "..."
            } else {
                return text
            }
        }
}

#Preview {
    CommunitiesCell("John Doe Community")
}
