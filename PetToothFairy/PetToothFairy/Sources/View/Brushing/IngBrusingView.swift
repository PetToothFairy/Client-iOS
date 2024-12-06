//
//  IngBrusingView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI
import CoreBluetooth

struct IngBrushingView: View {
  @ObservedObject var bluetoothManager: BluetoothManager
  @State private var currentImageName: String = "UP_FRONT"
  @State private var currentlocationKorean: String = "앞쪽 윗니"
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
      VStack {
        HStack {
          Button(action: {
            bluetoothManager.stopScanning()
            bluetoothManager.disconnect()
            dismiss()
          }) {
            Image("back_arrow")
              .resizable()
              .frame(width: 20, height: 20)
              .padding(.leading, 20)
          }
          Text("구강 상태")
            .font(.system(size: 24))
            .fontWeight(.bold)
          Spacer()
        }.padding(.top, 5)
        
        UpperView(locationText: $currentlocationKorean)
          .padding(.top, 20)
        Image(currentImageName)
          .frame(maxWidth: .infinity, maxHeight: 400, alignment: .center)
          .padding(.top, 20)
        Spacer()
    }
    .onChange(of: bluetoothManager.receivedData) { newValue in
      updateLocationName()
    }
    .onDisappear {
      bluetoothManager.stopScanning()
      bluetoothManager.disconnect()
    }
    .navigationBarBackButtonHidden(true)
  }
  
  private func updateLocationName() {
    if !bluetoothManager.receivedData.isEmpty {
      currentImageName = bluetoothManager.receivedData
      currentlocationKorean = getKoreanForReceivedValue(locationText: bluetoothManager.receivedData)
    }
  }
  
  private func getKoreanForReceivedValue(locationText: String) -> String {
    switch locationText {
    case "UNDER_FRONT": return "아랫쪽 앞니"
    case "UP_FRONT": return "윗쪽 앞니"
    case "UNDER_RIGHT_CANINE": return "아랫쪽 오른쪽 송곳니"
    case "UP_RIGHT_CANINE": return "윗쪽 오른쪽 송곳니"
    case "UNDER_RIGHT_MOLAR_OUTSIDE": return "아랫쪽 오른쪽 어금니 바깥쪽"
    case "UP_RIGHT_MOLAR_OUTSIDE": return "윗쪽 오른쪽 어금니 바깥쪽"
    case "UP_LEFT_MOLAR_CHEWING_SIDE": return "윗쪽 왼쪽 어금니 씹는쪽"
    case "UP_RIGHT_MOLAR_CHEWING_SIDE": return "윗쪽 오른쪽 어금니 씹는쪽"
    case "DOWN_RIGHT_MOLAR_CHEWING_SIDE": return "아랫쪽 오른쪽 어금니 씹는쪽"
    case "DOWN_LEFT_MOLAR_CHEWING_SIDE": return "아랫쪽 왼쪽 어금니 씹는쪽"
    case "UP_LEFT_MOLAR_OUTSIDE": return "윗쪽 왼쪽 어금니 바깥쪽"
    case "UNDER_LEFT_MOLAR_OUTSIDE": return "아랫쪽 왼쪽 어금니 바깥쪽"
    case "UNDER_LEFT_CANINE": return "아랫쪽 왼쪽 송곳니"
    case "UP_LEFT_CANINE": return "윗쪽 왼쪽 송곳니"
    default: return "양치중 😀"
    }
  }
}
