//
//  DiagnosisView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct DiagnosisView: View {
  let result: [DiagnosisModel]
  let imageSize: ImageDetails
  let count: Int
  @Binding var pickedImage: UIImage
  
  var body: some View {
    ZStack {
      VStack {
        Text("치석 판단")
          .font(.system(size: 24))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 28)
          .padding(.top, 16)
        
        mainContent
        Spacer()
      }
      .background(Color(hex: "F5F5F5"))
    }
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarHidden(true)
  }
  
  // 메인 콘텐츠를 위한 서브 뷰
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
        petHospitalMapView
        Spacer()
      }
      .frame(height: 380)
    }
  }
  
  // 진단 텍스트를 위한 서브 뷰
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
  
  // 이미지와 강조 표시된 치석 위치를 위한 서브 뷰
  private var imageWithAnnotations: some View {
    GeometryReader { geometry in
        ZStack {
            // 이미지를 중앙에 배치
            Image(uiImage: pickedImage)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize.cgWidth, height: imageSize.cgHeight)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
          
            // 결과 배열을 기준으로 사각형 그리기
            ForEach(result, id: \.self) { diagnosis in
                // 이미지 왼쪽 위를 기준으로 x, y 위치 계산
                let scaledX = CGFloat(diagnosis.position.x)
                let scaledY = CGFloat(diagnosis.position.y)

                Rectangle()
                    .stroke(Color.yellow, lineWidth: 2)
                    .frame(width: diagnosis.size.width, height: diagnosis.size.height)
                    .position(
                      x: (geometry.size.width / 2) + (scaledX - (imageSize.cgWidth / 2)), // 이미지 중앙을 기준으로 x 조정
                      y: (geometry.size.height / 2) + (scaledY - (imageSize.cgHeight / 2))  // 이미지 중앙을 기준으로 y 조정
                    )
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
    }
  }
  
  // 서비스 사용에 대한 안내 문구를 위한 서브 뷰
  private var disclaimerText: some View {
    Text("해당 치석 AI 판단 서비스는 전문의의 진료를 대체하지 않습니다. \n이 점을 고려하여 서비스를 이용해주시기 바랍니다.")
      .font(.system(size: 12))
      .scaledToFit()
      .padding(.top, 22)
  }
}

private var petHospitalMapView: some View {
  PetHospitalMapView()
    .frame()
}
