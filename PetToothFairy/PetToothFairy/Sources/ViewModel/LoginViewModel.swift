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
  @Published var loginResponse: TokensResponse
  @Published var showJoin: Bool
  @Published var showContent: Bool
  @Published var socialToken: String
  
  private var cancellables = Set<AnyCancellable>()
  
  init(){
    loginResponse = TokensResponse(accessToken: "", refreshToken: "")
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
      .publishDecodable(type: BasicResponse<TokensResponse>.self)
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
          case 403: // 회원가입
            self.loginResponse = receivedValue.data!
            self.socialToken = socialToken
            self.toggleJoin()
          case 200: // 재로그인
            self.loginResponse = receivedValue.data!
            TokenManager.accessToken = receivedValue.data?.accessToken
            TokenManager.refreshToken = receivedValue.data?.refreshToken
            self.toggleLogin()
            print("RE_LOGIN: ACCESS_TOKEN = \(receivedValue.data?.accessToken ?? ""), REFRESH_TOKEN = \(receivedValue.data?.refreshToken ?? "")")
          default:
            print("Unhandled status: \(receivedValue.status)")
          }
        }
      )
      .store(in: &cancellables)
  }
}
