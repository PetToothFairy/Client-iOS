//
//  PetToothFairyApp.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/07.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct PetToothFairyApp: App {
  @State private var isRegistered = false
  
  init() {
    KakaoSDK.initSDK(appKey:"30cf8da5716f717df417064047420c95")
  }
  
  var body: some Scene {
    WindowGroup {
      
      ContentView()
//      SignInWithKakaoButtonView()
//        .onOpenURL { url in
//          if (AuthApi.isKakaoTalkLoginUrl(url)) {
//            _ = AuthController.handleOpenUrl(url: url)
//          }
//        }
    }
  }
}
