//
//  ContentView.swift
//  Foody
//
//  Created by omar on 8/14/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Home().navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
