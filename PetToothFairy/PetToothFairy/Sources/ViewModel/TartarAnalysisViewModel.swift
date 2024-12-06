//
//  TartarAnalysisViewModel.swift
//  PetToothFairy
//
//  Created by 임주민 on 11/21/24.
//

import Foundation
import SwiftUI
import Combine

class TartarAnalysisViewModel: ObservableObject {
  @Published var imageSize: ImageDetails?
  @Published var analysisResult: [DiagnosisModel] = []
  @Published var isLoading: Bool = false
  
  private var cancellables = Set<AnyCancellable>()
  
  func analyzeImage(_ image: UIImage, completion: @escaping (Bool) -> Void) {
    isLoading = true
    
    TartarManager.shared.postTartarImage(image: image) { result in
      DispatchQueue.main.async {
        
        self.isLoading = false
        switch result {
        case .success(let data):
          do {
            let response = try JSONDecoder().decode(TartarResponse.self, from: data)
            self.analysisResult = self.analyzeResponse(response: response)
            self.imageSize = response.image
            completion(true)
          } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            self.analysisResult = []
            completion(false)
          }
        case .failure(let error):
          print("Error analyzing image: \(error.localizedDescription)")
          self.analysisResult = []
          completion(false)
        }
      }
    }
  }
  
  func analyzeResponse(response: TartarResponse) -> [DiagnosisModel] {
    let tartarPredictions = response.predictions.filter { prediction in
      prediction.predictionClass.lowercased().contains("tartar")
    }
    
    guard !tartarPredictions.isEmpty else {
      return []
    }
    
    let results = tartarPredictions.map { prediction in
      DiagnosisModel(
        confidence: prediction.confidence * 100, // 신뢰도는 백분율로 변환
        position: CGPoint(x: prediction.x, y: prediction.y),
        size: CGSize(width: CGFloat(prediction.width), height: CGFloat(prediction.height))
      )
    }
    
    return results
  }
}
