//
//  ImageView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/19.
//

import SwiftUI

struct ImageView: View {
  @Binding var pickedImage: UIImage
  var onImagePicked: (UIImage) -> Void
  
  @State private var showingImagePicker = false
  @State private var selectedSourceType: UIImagePickerController.SourceType = .camera
  @State private var isActionSheetPresented = false
  
  var body: some View {
    VStack {
      Button(action: {
        isActionSheetPresented.toggle()
      }) {
        Image("button_uploadImage")
          .frame(width: 111, height: 33)
      }
      .actionSheet(isPresented: $isActionSheetPresented) {
        ActionSheet(
          title: Text("Select Image Source"),
          buttons: [
            .default(Text("Camera")) {
              selectedSourceType = .camera
              showingImagePicker.toggle()
            },
            .default(Text("Photo Library")) {
              selectedSourceType = .photoLibrary
              showingImagePicker.toggle()
            },
            .cancel()
          ]
        )
      }
      .sheet(isPresented: $showingImagePicker) {
        SUImagePicker(selectedImage: $pickedImage, sourceType: selectedSourceType)
          .onDisappear {
            onImagePicked(pickedImage)
          }
      }
    }
  }
}
