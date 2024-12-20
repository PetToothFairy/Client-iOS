//
//  ImageView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/19.
//

import SwiftUI

struct ImageView: View {
  @Binding var pickedImage: UIImage
  
  @State private var showingImagePicker = false
  @State private var selectedSourceType: UIImagePickerController.SourceType = .camera
  @State private var isActionSheetPresented = false
  
  var onImagePicked: (UIImage) -> Void
  
  var body: some View {
    VStack {
      Button(action: {
        isActionSheetPresented.toggle()
      }) {
        ZStack{
          RoundedRectangle(cornerRadius: 15)
            .fill(
              LinearGradient(
                gradient: Gradient(colors: [.navy, .mediumBlue]),
                startPoint: .trailing,
                endPoint: .leading
              )
            )
            .frame(width: 253, height: 36)
          Text("사진 업로드하기")
            .font(.system(size: 16))
            .fontWeight(.bold)
            .foregroundColor(Color.white)
        }
      }
      .actionSheet(isPresented: $isActionSheetPresented) {
        ActionSheet(
          title: Text("Select Image Source"),
          buttons: [
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
