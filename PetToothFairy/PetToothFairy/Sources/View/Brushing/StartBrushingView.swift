//
//  StartBrushingView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI
import AVKit

struct StartBrushingView: View {
  @ObservedObject var homeViewModel: HomeViewModel
  @ObservedObject var bluetoothManager: BluetoothManager
  @StateObject private var audioPlayer = AudioPlayer()
  @State private var navigateToBrushing = false
  @State private var isConnected = false
  
  var body: some View {
    VStack {
      UpperTitleView(title: "양치 시작")
      ZStack {
        backWhiteView
        VStack{
          brushingContent
          if isConnected {
            guideView
          } else {
            bluetoothButton
            BluetoothTestView(bluetoothManager: bluetoothManager)
          }
        }
      }
    }
    .background(Color.backgroundColor)
    .onChange(of: bluetoothManager.connectedPeripheral) { connectedPeripheral in
      if connectedPeripheral != nil {
        handleConnection()
      }
    }
    .onAppear {
      setupView()
    }
  }
  
  private var backWhiteView: some View {
    RoundedRectangle(cornerRadius: 15)
      .fill(Color.white)
      .padding(.horizontal, 16)
  }
  
  private var guideView: some View {
    ZStack {
      NavigationLink(
        destination: IngBrushingView(bluetoothManager: bluetoothManager, brushingViewModel: BrushingViewModel()),
        isActive: $navigateToBrushing
      ) {
        EmptyView()
      }
      
      RoundedRectangle(cornerRadius: 15)
        .fill(Color.white)
        .padding(.horizontal, 16)
      
      VStack {
        Text("앞니의 위치를 확인 중입니다...\n잠시만 칫솔을 그대로 위치시켜 주세요!")
          .font(.system(size: 18))
          .lineSpacing(7)
          .padding(.top, 50)
        
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .blue))
          .scaleEffect(2)
          .padding(.top, 40)
        
        Spacer()
      }
    }
  }
  
  private var brushingContent: some View {
    VStack {
      Group {
        Text("\(homeViewModel.userResponse.petName)의 ")
        + Text("앞니").bold()
        + Text("에 칫솔을")
      }
      .padding(.top, 50)
      .font(.system(size: 20))
      Text("가져다 대고 시작해볼게요!")
        .font(.system(size: 20))
      
      Image("brushing_front")
        .scaleEffect(0.7)
        .frame(height: 230)
      Spacer()
    }
  }
  
  private var bluetoothButton: some View {
    Button(action: {
      bluetoothManager.startScanning()
    }) {
      ZStack {
        RoundedRectangle(cornerRadius: 15)
          .fill(
            LinearGradient(
              gradient: Gradient(colors: [.navy, .mediumBlue]),
              startPoint: .trailing,
              endPoint: .leading
            )
          )
          .frame(width: 253, height: 36)
        
        Text((bluetoothManager.connectedPeripheral != nil) ? "블루투스 연결됨" : "블루투스 켜기")
          .font(.system(size: 16))
          .fontWeight(.bold)
          .foregroundColor(.white)
      }
    }
    .padding(.top, 10)
  }
  
  private func setupView() {
    isConnected = false
    homeViewModel.getUserInfo()
    bluetoothManager.startScanning()
  }
  
  private func handleConnection() {
    isConnected = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      navigateToBrushing = true
    }
  }
}
