//
//  TokenManager.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/5/24.
//

import Foundation

struct TokenManager {
  static var accessToken: String? {
    get {
      UserDefaults.standard.string(forKey: "accessToken")
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: "accessToken")
    }
  }
  
  static var refreshToken: String? {
    get {
      UserDefaults.standard.string(forKey: "refreshToken")
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: "refreshToken")
    }
  }
}
