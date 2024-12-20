//
//  BrushingViewModel.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/9/24.
//

import Foundation
import Alamofire
import Combine

class BrushingViewModel: ObservableObject {
  @Published var showContent: Bool
  @Published var brushingResponse: BrushingResponse
  @Published var isLoading: Bool = false
  
  var subscription = Set<AnyCancellable>()
  
  init() {
    brushingResponse = BrushingResponse(reports: [], seq: 0)
    showContent = false
  }
  
  func toggleContent(){
    showContent.toggle()
  }
  
  func getBrushingResult(receivedArray: [String]) {
    isLoading = true
    
    AF.request(BrushingManager.getBrushingResults(accessToken: TokenManager.accessToken!, receivedArray: receivedArray))
      .publishDecodable(type: BasicResponse<BrushingResponse>.self)
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
          print("💜 \(receivedValue)")
          self?.brushingResponse = receivedValue.data!
          self?.isLoading = false
          if receivedValue.status == 200 {
            print(self?.brushingResponse.reports ?? "No Report")
            print(self?.brushingResponse.seq ?? "No Sequence")
            self?.toggleContent()
          } else {
            print("Failed with status \(receivedValue.status): \(receivedValue.message ?? "No message")")
          }
        }
      )
      .store(in: &subscription)
  }
}
