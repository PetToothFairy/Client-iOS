//
//  ContentView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct ContentView: View {
  @State private var selection: Tab = .brushing
  
  enum Tab {
    case brushing
    case tartar
    case mypage
  }
  
  init() {
    UITabBar.appearance().backgroundColor = UIColor(Color(hex: "1B1B23"))
  }
  
  var body: some View {
    TabView(selection: $selection) {
      NavigationStack {
        StartBrushingView()
      }
      .tabItem {
        Image("icon_toothbrush").renderingMode(.template)
        Text("양치 하기")
      }
      .tag(Tab.brushing)
      
      NavigationStack {
        UploadImageView()
      }
      .tabItem {
        Image("icon_diagnosis").renderingMode(.template)
        Text("치석 판단")
      }
      .tag(Tab.tartar)
      NavigationStack {
        MyPageView()
      }
      .tabItem {
        Image("icon_mypage").renderingMode(.template)
        Text("마이페이지")
      }
      .tag(Tab.mypage)
    }
    .tint(.white)
    .accentColor(Color(hex: "474753"))
    .navigationBarHidden(true)
  }
}
