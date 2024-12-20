//
//  IngBrushingView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI
import CoreBluetooth

struct IngBrushingView: View {
  @ObservedObject var bluetoothManager: BluetoothManager
  @StateObject var brushingViewModel: BrushingViewModel
  @StateObject private var audioPlayer = AudioPlayer()
  
  @State private var currentImageName = "UP_FRONT"
  @State private var currentlocationKorean = "앞쪽 윗니"
  @State private var alertOpacity = 1.0
  @State private var middleAudioTimer: Timer?
  @State private var endAudioTimer: Timer?
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      contentView
        .background(Color.backgroundColor)
      if brushingViewModel.isLoading {
        ProgressLoadingView()
      }
    }
    .onChange(of: bluetoothManager.receivedData) { _ in updateLocationName() }
    .onAppear(perform: onAppearActions)
    .onDisappear(perform: onDisappearActions)
    .sheet(isPresented: $brushingViewModel.showContent) {
      ResultBrushingView(brushingResponse: brushingViewModel.brushingResponse)
    }
    .navigationBarBackButtonHidden(true)
    .gesture(dismissGesture)
  }
}

private extension IngBrushingView {
  var contentView: some View {
    VStack {
      UpperTitleView(title: "구강 상태")
      ZStack {
        BackWhiteView()
        brushingContent
      }
    }
  }
  
  var brushingContent: some View {
    VStack {
      UpperView(locationText: $currentlocationKorean)
        .frame(width: UIScreen.main.bounds.width)
        .padding(.top, 20)
      Image(currentImageName)
        .resizable()
        .scaledToFit()
        .scaleEffect(1.3) 
        .frame(maxHeight: 400)
        .padding(.top, 20)
      Spacer()
    }
  }
  
  var dismissGesture: some Gesture {
    DragGesture().onEnded { value in
      if value.translation.width > 100 {
        dismiss()
      }
    }
  }
}

private struct BackWhiteView: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 15)
      .fill(Color.white)
      .frame(width: UIScreen.main.bounds.width)
      .padding(.horizontal, 16)
  }
}

private struct ProgressLoadingView: View {
  var body: some View {
    ZStack {
      Color.black.opacity(0.5)
      VStack {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .white))
          .scaleEffect(3)
          .padding(20)
          .shadow(radius: 10)
        Text("결과 분석 중...")
          .font(.subheadline)
          .foregroundColor(.white)
          .padding(.top, 10)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

private struct NotBrushingAlertView: View {
  var body: some View {
    ZStack {
      Color.gray.opacity(0.5)
      RoundedRectangle(cornerRadius: 15)
        .fill(Color.white)
        .frame(width: UIScreen.main.bounds.width - 60, height: 120)
        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 3)
      HStack {
        Text("💡").font(.system(size: 30))
        Text("칫솔이 치아에 닿지 않았습니다.\n올바르게 조정해주세요.")
          .font(.system(size: 18))
          .lineSpacing(7)
          .padding(.leading, 20)
      }
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

private extension IngBrushingView {
  func updateLocationName() {
    if !bluetoothManager.receivedData.isEmpty {
      currentImageName = bluetoothManager.receivedData
      currentlocationKorean = LocationUtils.getKoreanForReceivedValue(locationText: bluetoothManager.receivedData)
    }
  }
  
  func onAppearActions() {
    audioPlayer.playStartAudio()
    startTimer()
  }
  
  func onDisappearActions() {
    stopTimers()
    bluetoothManager.stopScanning()
    bluetoothManager.disconnect()
  }
  
  func startTimer() {
    middleAudioTimer = Timer.scheduledTimer(withTimeInterval: 58, repeats: false) { _ in
      audioPlayer.playMiddleAudio()
    }
    endAudioTimer = Timer.scheduledTimer(withTimeInterval: 120.5, repeats: false) { _ in
      audioPlayer.playEndAudio()
      bluetoothManager.stopScanning()
      bluetoothManager.disconnect()
      brushingViewModel.getBrushingResult(receivedArray: bluetoothManager.receivedDataArray)
    }
  }
  
  func stopTimers() {
    middleAudioTimer?.invalidate()
    endAudioTimer?.invalidate()
    middleAudioTimer = nil
    endAudioTimer = nil
  }
}
