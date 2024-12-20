//
//  HomeViewModel.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/11/24.
//

import Foundation
import Alamofire
import Combine

class HomeViewModel: ObservableObject {
  @Published var userResponse: UserResponse
  
  var subscription = Set<AnyCancellable>()
  
  init() {
    userResponse = UserResponse(petName: "", petWeight: 0)
  }
  
  func patchUserInfo(petName: String, petWeight: Int) {
    AF.request(UserManager.patchUserInfo(petName: petName, petWeight: petWeight))
      .publishDecodable(type: BasicResponse<UserResponse>.self)
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
          if receivedValue.status == 200 {
            self!.userResponse = receivedValue.data!
            print(receivedValue.data!)
          } else {
            print("Failed with status \(receivedValue.status): \(receivedValue.message ?? "No message")")
          }
        }
      )
      .store(in: &subscription)
  }
  
  func getUserInfo() {
    AF.request(UserManager.getUserInfo)
      .publishDecodable(type: BasicResponse<UserResponse>.self)
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
          if receivedValue.status == 200 {
            self!.userResponse = receivedValue.data!
          } else {
            print("Failed with status \(receivedValue.status): \(receivedValue.message ?? "No message")")
          }
        }
      )
      .store(in: &subscription)
  }
}
