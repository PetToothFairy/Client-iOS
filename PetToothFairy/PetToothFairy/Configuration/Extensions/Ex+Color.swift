//
//  Ex+Color.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import Foundation
import SwiftUI

extension Color {
  static let navy = Color(hex: "1D3680")
  static let mediumBlue = Color(hex: "3561E6")
  static let subFontColor = Color(hex: "50505E")
  static let backgroundColor = Color(hex: "F5F5F5")

  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
