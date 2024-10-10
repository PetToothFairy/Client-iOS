//
//  SignInWithKakaoButtonView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct SignInWithKakaoButtonView: View {
    var body: some View {
        NavigationView{
            VStack {
                Spacer(minLength: 236)
                
                HStack(spacing: 0){
                    Image("icon_toothbrush_blue")
                    
                    Text("양치코치")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "3561E6"))
                        .padding()
                }
                
                Spacer()
                
                NavigationLink(destination: RegisterView()) {
                    Image("button_kakaoLogin")
                        .padding(.bottom, 121)
                }
            }
        }
    }
}

struct SignInWithKakaoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithKakaoButtonView()
    }
}
