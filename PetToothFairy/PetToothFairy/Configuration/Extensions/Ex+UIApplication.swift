//
//  Ex_UIApplication.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/11/24.
//

import SwiftUI

extension UIApplication {
  func endEditing(_ force: Bool) {
    self.windows
      .filter { $0.isKeyWindow }
      .first?
      .endEditing(force)
  }
}
