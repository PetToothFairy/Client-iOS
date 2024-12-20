//
//  SplashView.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/16/24.
//

import SwiftUI

struct SplashView: View {
  @State private var isActive = false
  @State private var scale: CGFloat = 0.8
  @State private var opacity: Double = 0.0
  
  var body: some View {
    ZStack {
      Color.white
        .edgesIgnoringSafeArea(.all)
    
      Image("applogo") 
        .resizable()
        .scaledToFit()
        .frame(width: 150, height: 150)
        .scaleEffect(scale)
        .opacity(opacity)
        .onAppear {
          withAnimation(.easeOut(duration: 1)) {
            self.scale = 1.0
            self.opacity = 1.0
          }
        }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        self.isActive = true
      }
    }
    .fullScreenCover(isPresented: $isActive) {
      SignInWithKakaoButtonView()
    }
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView()
  }
}
