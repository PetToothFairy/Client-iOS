//
//  DiagnosisView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct DiagnosisView: View {
    var body: some View {
        ZStack{
            VStack {
                Text("치석 판단")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 28)
                    .padding(.top, 16)
                
                ZStack{
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 380)
                        .cornerRadius(10)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    
                    VStack(spacing: 22){
                        Group{
                            Text("1개")
                                .foregroundColor(Color(hex: "3561E6"))
                                .font(.system(size: 16))
                                .fontWeight(.semibold) +
                            Text("의 치석이 있는 것으로 추정돼요.")
                                .foregroundColor(.black)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                        }
                        .padding(.top, 46)
    
                        Image("image_tartar")
                            .frame(width: 284, height: 181)
                            
                        
                        Text("해당 치석 AI 판단 서비스는 전문의의 진료를 대체하지 않습니다. \n이 점을 고려하여 서비스를 이용해주시기 바랍니다.")
                            .font(.system(size: 10))
                            .padding(.top, 22)
                        Spacer()
                    }.frame(height: 380)
                }
                Spacer()
            }
            .background(Color(hex: "F5F5F5"))
       
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct DiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView()
    }
}
