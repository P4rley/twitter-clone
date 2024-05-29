//
//  SwiftUIView.swift
//  twitter-clone
//
//  Created by Adwitya Hersa on 13/05/24.
//

import SwiftUI

struct MessagesCell: View {
    var body: some View {
        HStack(alignment: .top) {
            CircularImageView(size: .large)
            
            VStack(alignment: .leading) {
                HStack(spacing: 3) {
                    Text("John Doe")
                        .foregroundStyle(Color.black)
                    
                    Text("@John_Doe")
                    
                    Text("\u{2022}")
                    
                    Text("03/05/24")
                    
                }
                .font(.system(size: 18))
                
                Text("Is there a reason for this? I'm not sure what would be different")
                
            }
            .foregroundStyle(Color.gray)
            
            Spacer()
        }
        .multilineTextAlignment(.leading)
        
    }
}

#Preview {
    MessagesView()
}
