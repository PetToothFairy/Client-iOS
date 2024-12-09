//
//  RegisterViewModel.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/5/24.
//

import Foundation
import Combine
import Alamofire

class RegisterViewModel: ObservableObject {
  @Published var showContent: Bool
  @Published var registerResponse: LoginResponse
  
  var subscription = Set<AnyCancellable>()
  
  init() {
    registerResponse = LoginResponse(status: 0, message: "", data: TokensResponse(accessToken: "", refreshToken: ""))
    showContent = false
  }
  
  func toggleRegister(){
    showContent.toggle()
  }
  
  func register(socialAccessToken: String, petName: String, petWeight: Int) {
    AF.request(UserManager.registerUser(socialAccessToken: socialAccessToken, petName: petName, petWeight: petWeight))
      .publishDecodable(type: LoginResponse.self)
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
          self?.registerResponse = receivedValue
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
