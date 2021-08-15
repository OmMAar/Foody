//
//  ItemView.swift
//  Foody
//
//  Created by omar on 8/15/21.
//

import SwiftUI
import SDWebImageSwiftUI
struct ItemView: View {
    var item : Item
    
    var body: some View {
        VStack{
            // Downloading image from web..
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width : UIScreen.main.bounds.width - 30 , height: 250, alignment: .center).clipped()
            
            HStack(spacing : 8){
                
                Text(item.item_name)
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                // Ratings View...
                ForEach(1...5,id: \.self){index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_rattings) ?? 0 ? .pink : .gray)
                    
                    
                }
                
            }
            
            HStack{
                Text(item.item_details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
            }
        }
    }
}


