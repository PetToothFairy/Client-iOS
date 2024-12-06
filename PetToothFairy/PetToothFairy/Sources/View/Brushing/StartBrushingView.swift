//
//  StartBrushingView.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/10/08.
//

import SwiftUI
import CoreBluetooth

struct StartBrushingView: View {

  @State private var connectedPeripheral: CBPeripheral?
  @StateObject private var bluetoothManager = BluetoothManager()
  
  var body: some View {
    VStack {
      Text("망고의 양치를 시작해볼까요?")
        .font(.system(size: 24))
        .fontWeight(.bold)
        .padding(.top, 177)
      
      NavigationLink(destination: IngBrushingView(bluetoothManager: bluetoothManager)) {
        Image("button_startBrushing")
          .padding(.top, 37)
      }
      
      BluetoothTestView(bluetoothManager: bluetoothManager)
      
      Spacer()
    }
    .onAppear {
      bluetoothManager.startScanning()
    }
  }
}
