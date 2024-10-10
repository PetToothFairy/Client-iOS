//
//  IngBrusingView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct IngBrusingView: View {
    var body: some View {
        VStack{
            Text("구강 상태")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 28)
                .padding(.top, 16)

            Image("image_tooth")
                .padding(.top, 61)
                .padding(.bottom, 162)

        }
 
    }
}

struct IngBrusingView_Previews: PreviewProvider {
    static var previews: some View {
        IngBrusingView()
    }
}
