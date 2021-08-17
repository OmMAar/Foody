//
//  ItemDetails.swift
//  Foody
//
//  Created by omar on 8/17/21.
//

import SwiftUI
import SDWebImageSwiftUI
struct ItemDetails: View {
    @StateObject var homeData : HomeViewModel
    let item : Item
    @Environment(\.presentationMode) var present
    var body: some View {
        VStack{
            HStack(spacing : 20){
                
                Button(action: {
                    present.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26 , weight : .heavy))
                        .foregroundColor(.red)
                })
                
                Text("My Details")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
                
            }.padding()
            
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                LazyVStack(spacing: 0){
                    WebImage(url: URL(string: item.item_image))
                        .resizable()
                        .aspectRatio(contentMode : .fill)
                        
                        .frame(width : UIScreen.main.bounds.width - 5 ,height : 450).clipped()
                        .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text(item.item_name)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.black))
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.top)
                            .padding(.horizontal)
                        
                        HStack {
                            Text("Price : ")
                                .fontWeight(.bold)
                                .foregroundColor(Color(.black))
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                          
                            Text("$\(item.item_cost)")
                                .fontWeight(.bold)
                                .foregroundColor(Color(.red))
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                               
                            Spacer()
                        }      .padding(.top)
                        .padding(.horizontal)
                        
                        Divider()
                        
                        Text(item.item_details)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .padding()
                       
                    }
                }
            }
            
            VStack{
                
              
                
                Button(action: {
                    homeData.addToCart(item: item)
                }){
                    
                    
                    HStack {
                        Spacer()
                        Image(systemName: item.isAdded ? "cart.fill.badge.minus" :"cart.badge.plus")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(item.isAdded ? Color.green : Color.red)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(width: 50, height: 50)
                        Text(item.isAdded ? "Remove From Cart": "Add To Cart")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                          
                        Spacer()
                    }
                }
                
            }  .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 30)
            .background(item.isAdded ? Color.green : Color.red)
            .cornerRadius(15)
            
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}


