//
//  AppStoreCloneApp.swift
//  AppStoreClone
//
//  Created by leejunmo on 2022/06/23.
//

import SwiftUI

@main
struct AppStoreCloneApp: App {
    @StateObject private var controller = Controller()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(controller)
        }
    }
}
