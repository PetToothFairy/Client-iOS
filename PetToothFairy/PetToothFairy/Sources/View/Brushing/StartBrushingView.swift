//
//  StartBrushingView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct StartBrushingView: View {
    var body: some View {
        VStack {
            Text("망고의 양치를 시작해볼까요?")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.top, 177)
            
            NavigationLink(destination: IngBrusingView()) {
                Image("button_startBrushing")
                    .padding(.top, 37)
            }
            Spacer()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct StartBrushingView_Previews: PreviewProvider {
    static var previews: some View {
        StartBrushingView()
    }
}
