//
//  UpperView.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/6/24.
//

import SwiftUI

struct UpperView: View {
  @Binding var locationText: String
  
  let height: CGFloat = 180
  
  var body: some View {
    ZStack{
      RoundedRectangle(cornerRadius: 15)
        .foregroundColor(.blue)
        .frame(height: height)
        .padding(.horizontal, 13)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 10)
      HStack{
        TimerView()
        VStack{
          Text("🦷 현재 닦고 있는 부위")
            .font(.system(size: 17))
            .padding(.bottom, 10)
            .fontWeight(.bold)
          ZStack{
            RoundedRectangle(cornerRadius: 10)
              .foregroundColor(.black.opacity(0.6))
              .frame(width: 170, height: 45)
            Text(locationText)
              .font(.system(size: 19))
              .fontWeight(.bold)
          }
        }
        .frame(height: height)
        .padding(.leading, 10)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 20)
    }
    .foregroundColor(.white)
  }
}

struct UpperView_Previews: PreviewProvider {
  static var previews: some View {
    UpperView(locationText: .constant("오른쪽 아래쪽 송곳니"))
  }
}
