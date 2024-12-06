//
//  LoginViewModel.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/12.
//

import Foundation
import Alamofire
import Combine

class LoginViewModel: ObservableObject {
  @Published var loginResponse: LoginResponse
  @Published var showJoin: Bool
  @Published var showContent: Bool
  @Published var socialToken: String
  
  private var cancellables = Set<AnyCancellable>()
  
  init(){
    loginResponse = LoginResponse(status: 0, body: "", message: Message(accessToken: "", refreshToken: ""))
    showJoin = false
    showContent = false
    socialToken = ""
  }
  
  func toggleJoin(){
    showJoin.toggle()
  }
  
  func toggleLogin(){
    showContent.toggle()
  }
  
  func postKakaoLogin(socialToken: String){
    print("LoginViewModel - postKakaoLogin() called")
    
    AF.request(LoginManager.postkakaoLogin(accessToken: socialToken))
      .publishDecodable(type: LoginResponse.self)
      .value()
      .print()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          if case .failure(let error) = completion {
            print("Error: \(error.localizedDescription)")
            if let responseCode = error.responseCode {
              print("Response Code: \(responseCode)")
            }
          }
        },
        receiveValue: { receivedValue in
          switch receivedValue.status {
          case 400:
            print("Error 400")
          case 500:
            print("Error 500")
          case 403: // 회원가입
            self.loginResponse = receivedValue
            self.socialToken = socialToken
            self.toggleJoin()
            print("SIGN_UP: SOCIAL_ACCESS_TOKEN = \(self.socialToken)")
            print(receivedValue.status)
          case 200: // 재로그인
            self.loginResponse = receivedValue
            TokenManager.accessToken = receivedValue.message?.accessToken
            TokenManager.refreshToken = receivedValue.message?.refreshToken
            self.toggleLogin()
            print("RE_LOGIN: ACCESS_TOKEN = \(receivedValue.message?.accessToken), REFRESH_TOKEN = \(receivedValue.message?.refreshToken)")
          default:
            print("Unhandled status: \(receivedValue.status)")
          }
        }
      )
      .store(in: &cancellables)
  }
}
