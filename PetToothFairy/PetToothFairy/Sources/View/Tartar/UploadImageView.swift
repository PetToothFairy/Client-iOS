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
    ZStack{
      VStack(spacing: 16){
        HStack{
          Text("치석 판단")
            .font(.system(size: 24))
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 28)
            .padding(.top, 16)
        }
        
        ZStack{
          Rectangle()
            .fill(Color.white)
            .frame(height:84)
            .cornerRadius(10)
            .padding(.leading, 16)
            .padding(.trailing, 16)
          HStack{
            Image("icon_magnifyingGlass")
              .padding(.leading, 36)
            VStack(spacing: 4){
              Text("망고에게 치석이 있는 것 같나요?")
                .font(.system(size: 10))
                .foregroundColor(Color(hex: "50505E"))
                .padding(.leading, 6)
                .frame(maxWidth: .infinity, alignment: .leading)
              Text("치석이 의심되는 부분을 AI로 판단할 수 있어요")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "0062FF"))
                .padding(.leading, 6)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
          }
        }
        
        ZStack{
          Rectangle()
            .fill(Color.white)
            .frame(height: 320)
            .cornerRadius(10)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .cornerRadius(10)
          
          VStack{
            Text("주의 사항")
              .fontWeight(.semibold)
              .font(.system(size: 16))
              .padding(.top, 24)
            Text("반려견의 입술을 들어올려 치아가 잘 보이도록 찍어주세요!")
              .font(.system(size: 12))
              .padding(.top, 10)
            HStack(spacing: 22){
              VStack(spacing: 6){
                Image("image_tartar2")
                Text("예시 사진")
                  .font(.system(size: 10))
                  .foregroundColor(Color(hex: "50505E"))
              }
              VStack(spacing: 6){
                Image("image_tartar3")
                Text("예시 사진")
                  .font(.system(size: 10))
                  .foregroundColor(Color(hex: "50505E"))
              }
            }.padding(.top, 24)
            
            Spacer()
            
            
            ImageView(pickedImage: $pickedImage) { selectedImage in
              tartarAnalysisVM.analyzeImage(selectedImage) { success in
                if success {
                  showingDiagnosisView = true
                } else {
                  print("분석 실패")
                }
              }
            }
            Spacer()
          }.frame(height: 320)
        } // ZStack
        
        
        Spacer()
        
      } // VStack
      .background(Color(hex: "F5F5F5"))
      
      if tartarAnalysisVM.isLoading {
        ZStack {
          Color.black
            .opacity(0.5)
          
          VStack {
            ProgressView()
              .foregroundStyle(.white)
              .progressViewStyle(CircularProgressViewStyle(tint: .white))
              .scaleEffect(3)
              .padding(20)
              .shadow(radius: 10)
            
            Text("치석 분석 중...")
              .font(.subheadline)
              .foregroundColor(.white)
              .padding(.top, 10)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      }
    } // ZStack
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarHidden(true)
    .sheet(isPresented: $showingDiagnosisView) {
      let imageSize = tartarAnalysisVM.imageSize
      let result = tartarAnalysisVM.analysisResult
      DiagnosisView(result: result, imageSize: imageSize!, count: result.count, pickedImage: $pickedImage)
    }
  }
}
