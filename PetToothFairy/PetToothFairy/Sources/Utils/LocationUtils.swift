//
//  LocationUtils.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/16/24.
//

import Foundation

struct LocationUtils {
  static func getKoreanForReceivedValue(locationText: String) -> String {
    switch locationText {
    case "UNDER_FRONT": return "아랫쪽 앞니"
    case "UP_FRONT": return "윗쪽 앞니"
    case "UNDER_RIGHT_CANINE": return "아랫쪽 오른쪽 송곳니"
    case "UP_RIGHT_CANINE": return "윗쪽 오른쪽 송곳니"
    case "UNDER_RIGHT_MOLAR_OUTSIDE": return "아랫쪽 오른쪽 어금니 바깥쪽"
    case "UP_RIGHT_MOLAR_OUTSIDE": return "윗쪽 오른쪽 어금니 바깥쪽"
    case "UP_LEFT_MOLAR_CHEWING_SIDE": return "윗쪽 왼쪽 어금니 씹는쪽"
    case "UP_RIGHT_MOLAR_CHEWING_SIDE": return "윗쪽 오른쪽 어금니 씹는쪽"
    case "DOWN_RIGHT_MOLAR_CHEWING_SIDE": return "아랫쪽 오른쪽 어금니 씹는쪽"
    case "DOWN_LEFT_MOLAR_CHEWING_SIDE": return "아랫쪽 왼쪽 어금니 씹는쪽"
    case "UP_LEFT_MOLAR_OUTSIDE": return "윗쪽 왼쪽 어금니 바깥쪽"
    case "UNDER_LEFT_MOLAR_OUTSIDE": return "아랫쪽 왼쪽 어금니 바깥쪽"
    case "UNDER_LEFT_CANINE": return "아랫쪽 왼쪽 송곳니"
    case "UP_LEFT_CANINE": return "윗쪽 왼쪽 송곳니"
    default: return "양치중 😀"
    }
  }
  
  static func getImageNameForReceivedValue(locationText: String) -> String {
    switch locationText {
    case "아랫쪽 앞니": return "UNDER_FRONT"
    case "윗쪽 앞니": return "UP_FRONT"
    case "아랫쪽 오른쪽 송곳니": return "UNDER_RIGHT_CANINE"
    case "윗쪽 오른쪽 송곳니": return "UP_RIGHT_CANINE"
    case "아랫쪽 오른쪽 어금니 바깥쪽": return "UNDER_RIGHT_MOLAR_OUTSIDE"
    case "윗쪽 오른쪽 어금니 바깥쪽": return "UP_RIGHT_MOLAR_OUTSIDE"
    case "윗쪽 왼쪽 어금니 씹는쪽": return "UP_LEFT_MOLAR_CHEWING_SIDE"
    case "윗쪽 오른쪽 어금니 씹는쪽": return "UP_RIGHT_MOLAR_CHEWING_SIDE"
    case "아랫쪽 오른쪽 어금니 씹는쪽": return "DOWN_RIGHT_MOLAR_CHEWING_SIDE"
    case "아랫쪽 왼쪽 어금니 씹는쪽": return "DOWN_LEFT_MOLAR_CHEWING_SIDE"
    case "윗쪽 왼쪽 어금니 바깥쪽": return "UP_LEFT_MOLAR_OUTSIDE"
    case "아랫쪽 왼쪽 어금니 바깥쪽": return "UNDER_LEFT_MOLAR_OUTSIDE"
    case "아랫쪽 왼쪽 송곳니": return "UNDER_LEFT_CANINE"
    case "윗쪽 왼쪽 송곳니": return "UP_LEFT_CANINE"
    default: return "no image"
    }
  }
}
