//
//  Controller.swift
//  AppStoreClone
//
//  Created by leejunmo on 2022/06/24.
//

import Foundation

class Controller: ObservableObject {
    @Published var showCardView: Bool = false
    @Published var selectedCard: String = "title"
    
    @Published var selectedCardId: String = ""
}
