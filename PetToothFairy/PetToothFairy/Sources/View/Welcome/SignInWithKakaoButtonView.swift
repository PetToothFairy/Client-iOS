//
//  SignInWithKakaoButtonView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI
import KakaoSDKUser

struct SignInWithKakaoButtonView: View {
  
  @StateObject var loginViewModel = LoginViewModel()
  
  var body: some View {
    NavigationView{
      VStack {
        Spacer(minLength: 236)
        
        HStack(spacing: 0){
          Image("icon_toothbrush_blue")
          
          Text("양치코치")
            .font(.system(size: 40))
            .fontWeight(.bold)
            .foregroundColor(Color(hex: "3561E6"))
            .padding()
        }
        
        Spacer()
        
        Button {
          if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
              if let error = error {
                print("👇 error 👇")
                print(error)
              }
              else {
                print("loginWithKakaoTalk() success.")
                print("👉accessToken: \(oauthToken!.accessToken)")
                print("👉refreshToken: \(oauthToken!.refreshToken)")
                
                self.loginViewModel.postKakaoLogin(socialToken: oauthToken!.accessToken)
              }
            }
          } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
              if let error = error {
                print("👇 error 👇")
                print(error)
              }
              else {
                print("loginWithKakaoTalk() success.")
                print("👉accessToken: \(oauthToken!.accessToken)")
                print("👉refreshToken: \(oauthToken!.refreshToken)")
                
                self.loginViewModel.postKakaoLogin(socialToken: oauthToken!.accessToken)
              }
            }
          }
        } label : {
          Image("button_kakaoLogin")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width : UIScreen.main.bounds.width * 0.9)
            .padding(.bottom, 121)
        }
        .fullScreenCover(isPresented: $loginViewModel.showJoin) {
          RegisterView(registerViewModel: RegisterViewModel(), socialToken: $loginViewModel.socialToken)
        }
        .fullScreenCover(isPresented: $loginViewModel.showContent) {
          ContentView()
        }
      }
    }
  }
}
