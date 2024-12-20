
//
//  MyPageView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/10.
//

import SwiftUI

struct MyPageView: View {
  @StateObject var homeViewModel: HomeViewModel
  @State private var name: String = ""
  @State private var kg: Int = 3
  @State private var showSuccessMessage = false
  
  let numberRange = 1...30
  
  var body: some View {
    VStack {
      UpperTitleView(title: "마이 페이지")
      ZStack{
        if showSuccessMessage {
            SuccessMessageView(message: "변경 성공하였습니다.")
        }
        ScrollView{
          ZStack{
            RoundedRectangle(cornerRadius: 15)
              .fill(Color.white)
              .frame(height: 72)
              .padding(.leading, 16)
              .padding(.trailing, 16)
            HStack{
              Image("icon_dog")
                .frame(width: 36, height: 36)
                .padding(.leading, 32)
              VStack(spacing: 4){
                Text("이름 : \(homeViewModel.userResponse.petName)")
                  .font(.system(size: 16))
                  .foregroundColor(.subFontColor)
                  .padding(.leading, 16)
                  .frame(maxWidth: .infinity, alignment: .leading)
                Text("몸무게 : \(homeViewModel.userResponse.petWeight)kg")
                  .font(.system(size: 16))
                  .foregroundColor(.subFontColor)
                  .padding(.leading, 16)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
            }
          }
          
          ZStack{
            RoundedRectangle(cornerRadius: 15)
              .fill(Color.white)
              .padding(.horizontal, 16)
              .frame(height: 480)
            VStack{
              Text("변경할 반려견의 이름을 알려주세요.")
                .font(.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .padding(.top, 35)
                .padding(.leading, 40)
              ZStack{
                TextField("", text: $name)
                  .tint(.black)
                  .padding(.leading, 40)
                  .padding(.trailing, 90)
                Divider()
                  .background(.gray)
                  .frame(height: 1)
                  .padding(.horizontal, 40)
                  .padding(.top, 43)
              }
              Button (action: {
                withAnimation {
                  showSuccessMessage = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                  withAnimation {
                    showSuccessMessage = false
                  }
                }
                homeViewModel.patchUserInfo(petName: name, petWeight: kg)
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
                  Text("이름 수정하기")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                }
              }
              .padding(.horizontal, 47)
              .padding(.top, 24)
              Text("변경할 반려견의 몸무게를 알려주세요.")
                .font(.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .padding(.leading, 40)
                .padding(.top, 60)
              Picker("숫자를 선택하세요", selection: $kg) {
                ForEach(numberRange, id: \.self) { number in
                  Text("\(number) kg").tag(number)
                }
              }
              .pickerStyle(WheelPickerStyle())
              .frame(width: 311, height: 103, alignment: .top)
              .padding(.top, 10)
              Button(action: {
                homeViewModel.patchUserInfo(petName: name, petWeight: kg)
                withAnimation {
                  showSuccessMessage = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                  withAnimation {
                    showSuccessMessage = false
                  }
                }
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
                  Text("몸무게 수정하기")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                }
              }
              .padding(.horizontal, 47)
              .padding(.top, 15)
              Spacer()
            }
          }.padding(.top, 13)
          Spacer()
        }
      }
    }
    .onTapGesture {
      UIApplication.shared.endEditing(true)
    }
    .onAppear {
      Task {
        kg = homeViewModel.userResponse.petWeight
        name = homeViewModel.userResponse.petName
      }
    }
    .background(Color.backgroundColor)
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarHidden(true)
  }
}

struct SuccessMessageView: View {
  let message: String
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15)
        .fill(Color.white)
        .frame(height: 72)
        .padding(.horizontal, 16)
        .padding(.top, 10)
      Text(message)
        .fontWeight(.bold)
    }
  }
}
