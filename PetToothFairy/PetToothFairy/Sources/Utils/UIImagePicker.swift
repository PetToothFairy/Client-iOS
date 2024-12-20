//
//  UIImagePicker.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/13.
//

import Foundation
import SwiftUI

struct UImagePicker: UIViewControllerRepresentable {
  
  typealias UIViewControllerType = UIImagePickerController
  
  @Environment(\.presentationMode)
  private var presentationMode
  
  let sourceType: UIImagePickerController.SourceType
  let imagePicked: (UIImage) -> ()
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let parent: UImagePicker
    
    init(parent: UImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
      if let image = info[.originalImage] as? UIImage {
        parent.imagePicked(image)
        parent.presentationMode.wrappedValue.dismiss()
      }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      parent.presentationMode.wrappedValue.dismiss()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    picker.sourceType = sourceType // sourceType 설정 추가
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    
  }
}
