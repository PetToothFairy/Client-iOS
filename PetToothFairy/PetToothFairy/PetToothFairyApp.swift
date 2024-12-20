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
    KakaoSDK.initSDK(appKey: APIConstants.kakaoAppKey)
  }
  
  var body: some Scene {
    WindowGroup {
      SplashView()
        .onOpenURL { url in
          if (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.handleOpenUrl(url: url)
          }
        }
    }
  }
}
