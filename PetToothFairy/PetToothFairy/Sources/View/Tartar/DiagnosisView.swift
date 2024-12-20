//
//  DiagnosisView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct DiagnosisView: View {
  @Binding var pickedImage: UIImage
  
  let result: [DiagnosisModel]
  let imageSize: ImageDetails
  let count: Int
  
  var body: some View {
    ZStack {
      VStack {
        UpperTitleView(title: "치석 판단")
        mainContent
        Spacer()
      }
      .background(Color.backgroundColor)
    }
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarHidden(true)
  }
  
  private var mainContent: some View {
    ZStack {
      Rectangle()
        .fill(Color.white)
        .frame(height: 380)
        .cornerRadius(10)
        .padding(.leading, 16)
        .padding(.trailing, 16)
      VStack(spacing: 22) {
        diagnosisText
        imageWithAnnotations
        disclaimerText
        Spacer()
      }
      .frame(height: 380)
    }
  }
  
  private var diagnosisText: some View {
    Group {
      Text("\(count)개")
        .foregroundColor(Color(hex: "3561E6"))
        .font(.system(size: 23))
        .fontWeight(.semibold) +
      Text("의 치석이 있는 것으로 추정돼요.")
        .foregroundColor(.black)
        .font(.system(size: 18))
        .fontWeight(.semibold)
    }
    .padding(.top, 46)
  }
  
  private var imageWithAnnotations: some View {
    GeometryReader { geometry in
      ZStack {
        Image(uiImage: pickedImage)
          .resizable()
          .scaledToFit()
          .frame(width: imageSize.cgWidth, height: imageSize.cgHeight)
          .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        ForEach(result, id: \.self) { diagnosis in
          let scaledX = CGFloat(diagnosis.position.x)
          let scaledY = CGFloat(diagnosis.position.y)
          Rectangle()
            .stroke(Color.yellow, lineWidth: 2)
            .frame(width: diagnosis.size.width, height: diagnosis.size.height)
            .position(
              x: (geometry.size.width / 2) + (scaledX - (imageSize.cgWidth / 2)),
              y: (geometry.size.height / 2) + (scaledY - (imageSize.cgHeight / 2))
            )
        }
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
    }
  }
  
  private var disclaimerText: some View {
    Text("해당 치석 AI 판단 서비스는 전문의의 진료를 대체하지 않습니다. \n이 점을 고려하여 서비스를 이용해주시기 바랍니다.")
      .font(.system(size: 12))
      .scaledToFit()
      .padding(.top, 22)
  }
}
