//
//  swwiftui_firebase_chatApp.swift
//  swwiftui-firebase-chat
//
//  Created by matheus.evangelista on 30/12/21.
//

import SwiftUI
import Firebase

@main
struct swwiftui_firebase_chatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthenticationView()
        }
    }
}
