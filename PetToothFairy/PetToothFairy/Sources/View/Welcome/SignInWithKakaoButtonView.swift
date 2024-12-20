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
        
        Image("applogo")
          .resizable()
          .scaledToFit()
          .frame(width: 130, height: 130)
        
        Text("양치코치")
          .font(.system(size: 20))
          .bold()
          .foregroundColor(.blue.opacity(0.8))
        
        Spacer()
        
        Button {
          //          if (UserApi.isKakaoTalkLoginAvailable()) {
          //            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
          //              if let error = error {
          //                print("👇 error 👇")
          //                print(error)
          //              }
          //              else {
          //                print("loginWithKakaoTalk() success.")
          //                print("👉accessToken: \(oauthToken!.accessToken)")
          //                print("👉refreshToken: \(oauthToken!.refreshToken)")
          //
          //                self.loginViewModel.postKakaoLogin(socialToken: oauthToken!.accessToken)
          //              }
          //            }
          //          } else {
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
        } label : {
          Image("button_kakaoLogin")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width : UIScreen.main.bounds.width * 0.9)
            .padding(.bottom, 100)
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
