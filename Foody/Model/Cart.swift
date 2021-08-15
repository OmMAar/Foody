//
//  Cart.swift
//  Foody
//
//  Created by omar on 8/15/21.
//

import SwiftUI

struct Cart : Identifiable {
    var id = UUID().uuidString
    var  item : Item
    var quantity : Int
    
    
}
