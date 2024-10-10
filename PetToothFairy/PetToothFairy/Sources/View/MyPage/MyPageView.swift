
//
//  MyPageView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/10.
//

import SwiftUI

struct MyPageView: View {
    @State private var name: String = ""
    @State private var kg: Int = 3
    
    let numberRange = 1...30
    
    var body: some View {
        VStack {
            Text("마이 페이지")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 28)
                .padding(.top, 16)
            
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
                        Text("이름 : 망고")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "50505E"))
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("몸무게 : 3kg")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "50505E"))
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.bottom, 119)
                
                VStack{
                    Text("변경할 반려견의 이름을 알려주세요.")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                        .padding(.top, 35)
                        .padding(.leading, 40)
                    
                    ZStack{
                        TextField("", text: $name)
                            .padding(.leading, 40)
                            .padding(.trailing, 90)
                        Divider()
                            .background(Color(hex: "3D3D3D"))
                            .frame(height: 1)
                            .padding(.leading, 40)
                            .padding(.trailing, 90)
                            .padding(.top, 43)
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(hex: "3561E6"))
                            .frame(width: 253, height: 36)
                        Text("이름 수정하기")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
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
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(hex: "3561E6"))
                            .frame(width: 253, height: 36)
                        Text("몸무게 수정하기")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    .padding(.horizontal, 47)
                    .padding(.top, 15)
                    
                    Spacer()
                }
            }.padding(.top, 13)

            Spacer()
        }
        .background(Color(hex: "F5F5F5"))
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
