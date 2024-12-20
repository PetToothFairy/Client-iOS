//
//  TartarAnalysisViewModel.swift
//  PetToothFairy
//
//  Created by 임주민 on 11/21/24.
//

import Foundation
import SwiftUI
import Combine

import Roboflow

class TartarAnalysisViewModel: ObservableObject {
  @Published var imageSize: ImageDetails?
  @Published var analysisResult: [DiagnosisModel] = []
  @Published var isLoading: Bool = false
  
  let rf = RoboflowMobile(apiKey: APIConstants.roboKey)
  var model: RFObjectDetectionModel?
  
  func getTartarDiagnosis(img: UIImage) {
    isLoading = true
    rf.load(model: "counttartar", modelVersion: 2) { [self] model, error, modelName, modelType in
      if error != nil {
        print(error?.localizedDescription as Any)
      } else {
        model?.configure(threshold: 0.5, overlap: 0.3, maxObjects: 10)
        self.model = model
      }
    }
    
    let resizeImg = resizeImage(image: img, targetSize: CGSize(width: 300, height: 180))
    
    model?.detect(image: resizeImg) { predictions, error in
      if error != nil {
        print(error ?? "error")
      } else {
        self.isLoading = false
        let dianosisModels = self.parsePredictions(predictions: predictions!)
        self.analysisResult = self.convertToDiagnosisModels(predictions: dianosisModels)
      }
    }
  }
  
  private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    let scaleFactor = min(widthRatio, heightRatio)
    
    let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
    
    self.imageSize = ImageDetails(width: size.width * scaleFactor, height: size.height * scaleFactor)
    UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
    image.draw(in: CGRect(origin: .zero, size: newSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resizedImage!
  }
  
  private func parsePredictions(predictions: [RFObjectDetectionPrediction]) -> [[String: Any]] {
    var res = [[String: Any]]()
    for det in predictions {
      res.append(det.getValues())
    }
    return res
  }
  
  private func convertToDiagnosisModels(predictions: [[String: Any]]) -> [DiagnosisModel] {
    var models: [DiagnosisModel] = []
    
    for prediction in predictions {
      guard let confidence = prediction["confidence"] as? Double,
            let x = prediction["x"] as? Float,
            let y = prediction["y"] as? Float,
            let width = prediction["width"] as? Float,
            let height = prediction["height"] as? Float else {
        print("Error: Missing or invalid data in prediction: \(prediction)")
        continue
      }
      
      let position = CGPoint(x: Double(x), y: Double(y))
      let size = CGSize(width: Double(width), height: Double(height))
      
      let model = DiagnosisModel(confidence: confidence, position: position, size: size)
      models.append(model)
    }
    
    return models
  }
}
