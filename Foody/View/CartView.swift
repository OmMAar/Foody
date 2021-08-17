//
//  CartView.swift
//  Foody
//
//  Created by omar on 8/15/21.
//

import SwiftUI
import SDWebImageSwiftUI
struct CartView: View {
    
    @StateObject var homeData : HomeViewModel
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
                
                Text("My Cart")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
                
            }.padding()
            
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                LazyVStack(spacing: 0){
                    ForEach(homeData.cartItems) { cart in
                        // Cart ItemView....
                        
                        HStack(spacing : 15){
                            WebImage(url: URL(string: cart.item.item_image))
                                .resizable()
                                .aspectRatio(contentMode : .fill)
                                .frame(width : 130,height : 130)
                                .cornerRadius(15)
                            
                            VStack(alignment: .leading, spacing: 10){
                                
                                Text(cart.item.item_name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                Text(cart.item.item_details)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                                
                                
                                HStack(spacing : 15){
                                    Text(homeData.getPrice(value: Float(truncating: cart.item.item_cost)))
                                        .font(.title2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Button(action: {
                                            if cart.quantity > 1{homeData.cartItems[homeData.getIndex(item: cart.item, isCartIndex: true)].quantity -= 1 }
                                            
                                        }){
                                        
                                            Image(systemName: "minus")
                                                .font(.system(size: 16, weight : .heavy))
                                                .foregroundColor(.white)
                                        } .padding(.horizontal,3)
                                        
                                        Text("\(cart.quantity)")
                                            .fontWeight(.heavy)
                                            .foregroundColor(.white)
                                            .padding(.vertical,5)
                                            .padding(.horizontal,10)
                                        
                                        
                                        Button(action: {
                                            homeData.cartItems[homeData.getIndex(item: cart.item, isCartIndex: true)].quantity += 1
                                            
                                        }){
                                        
                                            Image(systemName: "plus")
                                                .font(.system(size: 16, weight : .heavy))
                                                .foregroundColor(.white)
                                        }.padding(.horizontal,3)
                                        
                                    }.background(Color.yellow).cornerRadius(5)
                                    
                                    
                                }
                            }
                            
                        }.padding().contextMenu{
                            // for deleting order....
                            Button(action: {
                                
                                // deleting items from cart....
                                let index = homeData.getIndex(item: cart.item, isCartIndex: true)
                                let itemIndex = homeData.getIndex(item: cart.item, isCartIndex: false)
                                
                                homeData.items[itemIndex].isAdded = false
                                homeData.filtered[itemIndex].isAdded = false
                                
                                homeData.cartItems.remove(at: index)
                                
                                
                            }) {
                             Text("Remove")
                            }
                        }
                       
                       
                    }
                }
            }
            
            // Bottom View....
            VStack{
                
                HStack{
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // caluulating total price...
                    
                    Text(homeData.calulcaltingPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }.padding([.top,.horizontal])
                
                Button(action: homeData.updtateOrder){
                    Text(homeData.ordered ? "Cancel Order" : "Check Out")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.red)
                        .cornerRadius(15)
                }
                
            }.background(Color.white)
            
            
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    

}


