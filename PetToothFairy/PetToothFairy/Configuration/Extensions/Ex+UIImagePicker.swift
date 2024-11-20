//
//  Ex+UIImagePicker.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/19.
//

import SwiftUI

struct SUImagePicker: UIViewControllerRepresentable {
  
  typealias UIViewControllerType = UIImagePickerController
  
  @Binding var selectedImage: UIImage
  @Environment(\.presentationMode) private var presentationMode 
  let sourceType: UIImagePickerController.SourceType
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var parent: SUImagePicker
    
    init(parent: SUImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let image = info[.originalImage] as? UIImage {
        parent.selectedImage = image
      }
      parent.presentationMode.wrappedValue.dismiss()
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
    
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
  }
}
