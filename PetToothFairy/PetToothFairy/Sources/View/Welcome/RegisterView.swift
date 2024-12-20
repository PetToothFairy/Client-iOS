//
//  RegisterView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct RegisterView: View {
  @ObservedObject var registerViewModel: RegisterViewModel
  
  @Binding var socialToken: String
  
  @State private var name: String = ""
  @State private var kg: Int = 0
  
  let numberRange = 1...30
  
  var body: some View {
    ZStack {
      ZStack{
        Color.backgroundColor
          .ignoresSafeArea()
        
        VStack {
          VStack{
            Text("반려견 양치 생활")
              .font(.title)
              .bold()
              .foregroundColor(Color.blue)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 27)
              .padding(.top, 36)
            
            Text("에 더 도움이 될 수 있도록\n몇 가지를 여쭤볼게요.")
              .font(.title)
              .lineSpacing(10)
              .bold()
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 27)
              .padding(.top, 1)
          }
          
          ZStack {
            RoundedRectangle(cornerRadius: 30)
              .foregroundColor(Color.white)
              .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: -2)
              .padding(.top, 20)
            
            VStack{
              Text("반려견의 이름을 알려주세요.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .padding(.leading, 27)
                .padding(.top, 80)
              
              ZStack{
                TextField("", text: $name)
                  .padding(.leading, 27)
                  .padding(.trailing, 90)
                Divider()
                  .background(Color.black)
                  .padding(.leading, 27)
                  .padding(.trailing, 90)
                  .padding(.top, 43)
              }
              
              Text("반려견의 몸무게를 알려주세요.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .padding(.leading, 27)
                .padding(.top, 60)
              Picker("숫자를 선택하세요", selection: $kg) {
                ForEach(numberRange, id: \.self) { number in
                  Text("\(number) kg").tag(number)
                }
              }
              .pickerStyle(WheelPickerStyle())
              .frame(maxHeight: 150, alignment: .top)
              
              Button {
                registerViewModel.register(socialAccessToken: socialToken, petName: name, petWeight: kg)
              } label : {
                ZStack {
                  RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(hex: "3561E6"))
                    .frame(height: 48)
                  Text("작성 완료")
                    .bold()
                    .foregroundColor(Color.white)
                }.padding(.horizontal, 47)
                  .padding(.top, 50)
              }
              .fullScreenCover(isPresented: $registerViewModel.showContent) {
                ContentView()
              }
              
              Spacer()
            }
          }
          .ignoresSafeArea()
        }
      }
    }
    .padding(.top, 0)
    .navigationBarBackButtonHidden(true)
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarHidden(true)
    .background(Color.clear)
  }
}
