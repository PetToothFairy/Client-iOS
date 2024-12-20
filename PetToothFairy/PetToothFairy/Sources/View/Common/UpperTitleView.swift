//
//  UpperTitleView.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/9/24.
//

import SwiftUI

struct UpperTitleView: View {
  @State var title: String
  
  var body: some View {
      Text(title)
        .font(.system(size: 24))
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 28)
        .padding(.top, 16)
  }
}

#Preview {
  UpperTitleView(title: "Title")
}
