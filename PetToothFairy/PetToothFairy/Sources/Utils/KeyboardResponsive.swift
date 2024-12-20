//
//  KeyboardResponsive.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/11/24.
//

import Combine
import SwiftUICore
import UIKit

struct KeyboardResponsive: ViewModifier {
  @State private var offset: CGFloat = 0
  private let publisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
  
  func body(content: Content) -> some View {
    content
      .padding(.bottom, offset) // 키보드 높이만큼 패딩 추가
      .onReceive(publisher) { notification in
        if let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
          DispatchQueue.main.async {
            self.offset = value.minY < UIScreen.main.bounds.height ? value.height : 0
          }
        }
      }
      .onTapGesture {
        UIApplication.shared.endEditing(true)
      }
  }
}

extension View {
  func keyboardResponsive() -> some View {
    self.modifier(KeyboardResponsive())
  }
}
