//
//  DiagnosisModel.swift
//  PetToothFairy
//
//  Created by 임주민 on 11/21/24.
//

import Foundation

struct DiagnosisModel: Identifiable, Hashable {
  let id = UUID()
  let confidence: Double
  let position: CGPoint
  let size: CGSize
}

struct ImageDetails: Codable {
  let width: CGFloat
  let height: CGFloat
  
  var cgWidth: CGFloat {
    return CGFloat(width)
  }
  
  var cgHeight: CGFloat {
    return CGFloat(height)
  }
}
