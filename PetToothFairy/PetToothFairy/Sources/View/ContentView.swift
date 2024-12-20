//
//  ContentView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI

struct ContentView: View {
  @State private var selection: Tab = .brushing
  @StateObject private var homeViewModel = HomeViewModel()
  @StateObject private var bluetoothManager = BluetoothManager()
  
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
      createTabView(for: .brushing, view: StartBrushingView(homeViewModel: homeViewModel, bluetoothManager: bluetoothManager), iconName: "icon_toothbrush", title: "양치 하기")
      
      createTabView(for: .tartar, view: UploadImageView(), iconName: "icon_diagnosis", title: "치석 판단")
      
      createTabView(for: .mypage, view: MyPageView(homeViewModel: homeViewModel), iconName: "icon_mypage", title: "마이페이지")
    }
    .tint(.white)
    .accentColor(Color(hex: "474753"))
    .navigationBarHidden(true)
  }
  
  private func createTabView<Content: View>(for tab: Tab, view: Content, iconName: String, title: String) -> some View {
    NavigationStack {
      view
    }
    .tabItem {
      Image(iconName).renderingMode(.template)
      Text(title)
    }
    .tag(tab)
  }
}
