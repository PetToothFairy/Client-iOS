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
  
  var body: some View {
    VStack {
      UpperTitleView(title: "마이 페이지")
      ScrollView {
        PetInfoView(homeViewModel: homeViewModel)
        EditPetInfoView(homeViewModel: homeViewModel, name: $name, kg: $kg)
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

struct PetInfoView: View {
  @StateObject var homeViewModel: HomeViewModel
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15)
        .fill(Color.white)
        .frame(height: 72)
        .padding(.horizontal, 16)
      HStack {
        Image("icon_dog")
          .frame(width: 36, height: 36)
          .padding(.leading, 32)
        VStack(spacing: 4) {
          Text("이름 : \(homeViewModel.userResponse.petName)")
            .font(.system(size: 16))
            .foregroundColor(.subFontColor)
            .frame(maxWidth: .infinity, alignment: .leading)
          Text("몸무게 : \(homeViewModel.userResponse.petWeight)kg")
            .font(.system(size: 16))
            .foregroundColor(.subFontColor)
            .frame(maxWidth: .infinity, alignment: .leading)
        }.padding(.leading, 15)
      }
    }
  }
}

struct EditPetInfoView: View {
  @StateObject var homeViewModel: HomeViewModel
  @Binding var name: String
  @Binding var kg: Int
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15)
        .fill(Color.white)
        .padding(.horizontal, 16)
        .frame(height: 480)
      VStack {
        EditNameView(name: $name, title: "변경할 반려견의 이름을 알려주세요.")
        ActionButton(title: "이름 수정하기") {
          updateUserInfo()
        }
        .padding(.top, 24)
        EditWeightView(kg: $kg, title: "변경할 반려견의 몸무게를 알려주세요.")
        ActionButton(title: "몸무게 수정하기") {
          updateUserInfo()
        }
        .padding(.top, 15)
        Spacer()
      }
    }
    .padding(.top, 13)
  }
  
  private func updateUserInfo() {
    homeViewModel.patchUserInfo(petName: name, petWeight: kg)
  }
}

struct EditNameView: View {
  @Binding var name: String
  
  let title: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.system(size: 16))
        .bold()
        .padding(.leading, 40)
      ZStack {
        TextField("", text: $name)
          .tint(.black)
          .padding(.horizontal, 40)
        Divider()
          .background(.gray)
          .frame(height: 1)
          .padding(.horizontal, 40)
          .padding(.top, 43)
      }
    }
    .padding(.top, 35)
  }
}

struct EditWeightView: View {
  @Binding var kg: Int
  
  let title: String
  let numberRange = 1...30
  
  var body: some View {
    VStack() {
      HStack{
        Text(title)
          .font(.system(size: 16))
          .bold()
          .padding(.leading, 40)
        Spacer()
      }
      
      Picker("숫자를 선택하세요", selection: $kg) {
        ForEach(numberRange, id: \.self) { number in
          Text("\(number) kg").tag(number)
        }
      }
      .pickerStyle(WheelPickerStyle())
      .frame(width: 311, height: 103, alignment: .top)
      .padding(.top, 10)
    }
    .padding(.top, 60)
  }
}

struct ActionButton: View {
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      ZStack {
        RoundedRectangle(cornerRadius: 15)
          .fill(
            LinearGradient(
              gradient: Gradient(colors: [.navy, .mediumBlue]),
              startPoint: .trailing,
              endPoint: .leading
            )
          )
          .frame(width: 253, height: 36)
        Text(title)
          .font(.system(size: 16))
          .fontWeight(.bold)
          .foregroundColor(Color.white)
      }
    }
    .padding(.horizontal, 47)
  }
}
