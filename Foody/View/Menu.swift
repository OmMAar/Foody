//
//  Menu.swift
//  Foody
//
//  Created by omar on 8/14/21.
//

import SwiftUI

struct Menu: View {
    
    @ObservedObject var homeData = HomeViewModel()
    
    var body: some View {
        VStack {
          
            NavigationLink (
                destination: CartView(homeData: homeData)){
                
                HStack(spacing: 15){
                    Image(systemName: "cart")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.pink)
                    
                    Text("Cart")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    
                }.padding()
            }
            
            Spacer()
            
            HStack{
                Spacer()
                
                Text("Version 0.1")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.pink)
            }
            .padding(10)
        }.padding([.top,.trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea())
    }
}


