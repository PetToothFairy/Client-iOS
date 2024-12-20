//
//  RegisterViewModel.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/5/24.
//

import Foundation
import Alamofire
import Combine

class RegisterViewModel: ObservableObject {
  @Published var showContent: Bool
  @Published var registerResponse: TokensResponse
  
  var subscription = Set<AnyCancellable>()
  
  init() {
    registerResponse = TokensResponse(accessToken: "", refreshToken: "")
    showContent = false
  }
  
  func toggleRegister(){
    showContent.toggle()
  }
  
  func register(socialAccessToken: String, petName: String, petWeight: Int) {
    AF.request(UserManager.registerUser(socialAccessToken: socialAccessToken, petName: petName, petWeight: petWeight))
      .publishDecodable(type: BasicResponse<TokensResponse>.self)
      .value()
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            print("Register Request completed.")
          case .failure(let error):
            print("Error: \(error)")
          }
        },
        receiveValue: { [weak self] receivedValue in
          self?.registerResponse = receivedValue.data!
          if receivedValue.status == 200 {
            self?.toggleRegister()
            TokenManager.accessToken = receivedValue.data?.accessToken
            TokenManager.refreshToken = receivedValue.data?.refreshToken
            print("👉 Access Token : \(receivedValue.data?.accessToken ?? "No Access Token")")
            print("👉 Refresh Token : \(receivedValue.data?.refreshToken ?? "No Refresh Token")")
          } else {
            print("Failed with status \(receivedValue.status): \(receivedValue.message ?? "No message")")
          }
        }
      )
      .store(in: &subscription)
  }
}
