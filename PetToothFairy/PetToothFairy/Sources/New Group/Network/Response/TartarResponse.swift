//
//  TartarResponse.swift
//  PetToothFairy
//
//  Created by 임주민 on 11/21/24.
//

import Foundation

struct TartarResponse: Codable {
  let inferenceID: String
  let time: Double
  let image: ImageDetails
  let predictions: [Prediction]
  
  enum CodingKeys: String, CodingKey {
    case inferenceID = "inference_id"
    case time
    case image
    case predictions
  }
}

struct ImageDetails: Codable {
  let width: Int
  let height: Int
  
  var cgWidth: CGFloat {
    return CGFloat(width)
  }
  
  var cgHeight: CGFloat {
    return CGFloat(height)
  }
}

struct Prediction: Codable {
  let x: Double
  let y: Double
  let width: Double
  let height: Double
  let confidence: Double
  let predictionClass: String 
  let classID: Int
  let detectionID: String
  
  enum CodingKeys: String, CodingKey {
    case x, y, width, height, confidence
    case predictionClass = "class"
    case classID = "class_id"
    case detectionID = "detection_id"
  }
}
