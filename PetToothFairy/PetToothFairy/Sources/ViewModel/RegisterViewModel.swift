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
  var subscription = Set<AnyCancellable>()
  
  @Published var registerResponse: LoginResponse
  
  init() {
    registerResponse = LoginResponse(status: 0, body: "", message: Message(accessToken: "", refreshToken: ""))
    print(#fileID, #function, #line, "")
  }
  
  func register(socialAccessToken: String, petName: String, petWeight: Int) {
    AF.request(UserManager.registerUser(socialAccessToken: socialAccessToken, petName: petName, petWeight: petWeight))
      .publishDecodable(type: LoginResponse.self)
      .value()
      .sink(
        receiveCompletion: { completion in
        },
        receiveValue: { receivedValue in
          self.registerResponse = receivedValue
        })
      .store(in: &subscription)
  }
}
