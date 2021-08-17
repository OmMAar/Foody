//
//  Home.swift
//  Foody
//
//  Created by omar on 8/14/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        ZStack{
            
            VStack(spacing : 10){
                
                HStack(spacing : 15){
                    
                    Button(action: {
                        withAnimation(.easeIn){
                            HomeModel.showMenu.toggle()
                        }
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.pink)
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Locating..." : "Delivery To")
                        .foregroundColor(.black)
                    Text(HomeModel.userAddres)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.red)

                    Spacer(minLength: 0)
                    
                }.padding([.horizontal,.top])
                
               Divider()
                
                HStack(spacing : 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search" , text : $HomeModel.search)
//                    if HomeModel.search != "" {
//                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//
//
//                        }).animation(.easeIn)
//                    }
                }.padding(.horizontal).padding(.top, 10)
                
                Divider()
                
                if HomeModel.items.isEmpty{
                    Spacer()
                    ProgressView()
                    Spacer()
                }else {
                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                        VStack(spacing : 25){
                            ForEach(HomeModel.filtered){item in
                                
                                // item view
                                NavigationLink (
                                    destination: ItemDetails(homeData : HomeModel, item: item)){
                                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                        ItemView(item: item)
                                        
                                        HStack{
                                            
                                            Text("$\(item.item_cost)")
                                                .foregroundColor(.white)
                                                .padding(.vertical,10)
                                                .padding(.horizontal)
                                                .background(Color.yellow)
                                                
                                            
                                            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                            
                                            Button(action: {
                                                HomeModel.addToCart(item: item)
                                            }, label: {
                                                Image(systemName: item.isAdded ? "cart.fill.badge.minus" :"cart.badge.plus")
                                                    .foregroundColor(.white)
                                                    .padding(10)
                                                    .background(item.isAdded ? Color.green : Color.red)
                                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                            })
                                        }
                                        .padding(.trailing,10)
                                        .padding(.top,10)
                                       
                                    })     .frame(width : UIScreen.main.bounds.width - 30)
                                }
                              
                            }
                        }.padding(.top,10)
                    })
                }
                
                
            }
            
            // Side Menu ...
            
            HStack{
                Menu(homeData: HomeModel)
                    // Move Effect from Left...
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }.background(Color.black.opacity(HomeModel.showMenu ? 0.3 :  0).ignoresSafeArea()
            // closing when tap on outside ...
                            .onTapGesture(perform: {
                                withAnimation(.easeIn){
                                    HomeModel.showMenu.toggle()
                                }
                            })
            )
           
            
            // non closabl alert if permission denied...
            if HomeModel.noLocation {
                Text("Please Enable Location Access In Settings To Further Move On !!!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100 , height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
        .onAppear(perform: {
            // calling location delegate ...
            HomeModel.locationMangager.delegate = HomeModel
        
        })
        .onChange(of: HomeModel.search, perform: { value in
            // To Avoid Continues Search requests....
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                if value == HomeModel.search && HomeModel.search != "" {
                    //Search Data...
                    HomeModel.filterData()
                    
                }
            }
            
            if HomeModel.search == "" {
                // Reset All Data....
                withAnimation(.linear){
                    HomeModel.filtered = HomeModel.items
                }
            }
        })
    }
}
