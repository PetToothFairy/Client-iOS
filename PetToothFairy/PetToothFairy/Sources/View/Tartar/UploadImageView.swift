//
//  UploadImageView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct UploadImageView: View {
  @StateObject private var tartarAnalysisVM = TartarAnalysisViewModel()
  @State private var showingDiagnosisView = false
  @State private var pickedImage: UIImage = UIImage(imageLiteralResourceName: "image_noimage")
  
  var body: some View {
    ZStack {
      VStack(spacing: 16) {
        UpperTitleView(title: "치석 판단")
        InfoCardView()
        InstructionCardView(pickedImage: $pickedImage, tartarAnalysisVM: tartarAnalysisVM, showingDiagnosisView: $showingDiagnosisView)
        Spacer()
      }
      .background(Color.backgroundColor)
      if tartarAnalysisVM.isLoading {
        LoadingOverlayView()
      }
    }
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarHidden(true)
    .sheet(isPresented: $showingDiagnosisView) {
      let imageSize = tartarAnalysisVM.imageSize
      let result = tartarAnalysisVM.analysisResult
      DiagnosisView(pickedImage: $pickedImage, result: result, imageSize: imageSize!, count: result.count)
    }
  }
}

struct InfoCardView: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.white)
        .frame(height: 84)
        .padding(.horizontal, 16)
      HStack {
        Image("icon_magnifyingGlass")
          .padding(.leading, 36)
        VStack(spacing: 4) {
          Text("이빨에 치석이 있는 것 같나요?")
            .font(.system(size: 13))
            .foregroundColor(Color(hex: "50505E"))
            .frame(maxWidth: .infinity, alignment: .leading)
          Text("치석이 의심되는 부분을 AI로 판단할 수 있어요")
            .font(.system(size: 14))
            .bold()
            .foregroundColor(Color(hex: "0062FF"))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        Spacer()
      }
    }
  }
}

struct InstructionCardView: View {
  @Binding var pickedImage: UIImage
  @ObservedObject var tartarAnalysisVM: TartarAnalysisViewModel
  @Binding var showingDiagnosisView: Bool
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.white)
        .frame(height: 320)
        .padding(.horizontal, 16)
      VStack {
        Text("주의 사항")
          .fontWeight(.semibold)
          .font(.system(size: 20))
          .padding(.top, 24)
        Text("반려견의 입술을 들어올려 치아가 잘 보이도록 찍어주세요!")
          .font(.system(size: 13))
          .padding(.top, 10)
        ExampleImagesView()
          .padding(.top, 24)
        Spacer()
        ImageView(pickedImage: $pickedImage) { selectedImage in
          tartarAnalysisVM.getTartarDiagnosis(img: selectedImage)
          showingDiagnosisView = true
        }
        Spacer()
      }
      .frame(height: 320)
    }
  }
}

struct ExampleImagesView: View {
  var body: some View {
    HStack(spacing: 22) {
      ExampleImageView(imageName: "image_tartar2")
      ExampleImageView(imageName: "image_tartar3")
    }
  }
}

struct ExampleImageView: View {
  let imageName: String
  
  var body: some View {
    VStack(spacing: 6) {
      Image(imageName)
      Text("예시 사진")
        .font(.system(size: 13))
        .foregroundColor(Color(hex: "50505E"))
    }
  }
}

struct LoadingOverlayView: View {
  var body: some View {
    ZStack {
      Color.black
        .opacity(0.5)
        .ignoresSafeArea()
      VStack {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .white))
          .scaleEffect(3)
          .padding(20)
          .shadow(radius: 10)
        Text("치석 분석 중...")
          .font(.subheadline)
          .foregroundColor(.white)
          .padding(.top, 10)
      }
    }
  }
}
