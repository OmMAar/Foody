//
//  CartViewModel.swift
//  Foody
//
//  Created by omar on 8/15/21.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var items : [Item] = []
}

