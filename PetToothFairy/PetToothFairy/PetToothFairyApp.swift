//
//  PetToothFairyApp.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/07.
//

import SwiftUI

@main
struct PetToothFairyApp: App {
    @State private var isRegistered = false
    
    var body: some Scene {
        WindowGroup {
            SignInWithKakaoButtonView()
        }
    }
}
