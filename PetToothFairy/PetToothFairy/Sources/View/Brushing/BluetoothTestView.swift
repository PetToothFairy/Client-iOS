//
//  Untitled.swift
//  PetToothFairy
//
//  Created by 임주민 on 11/20/24.
//

import SwiftUI
import CoreBluetooth

import SwiftUI
import CoreBluetooth

struct BluetoothTestView: View {
  @ObservedObject var bluetoothManager: BluetoothManager
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    VStack {
      List(bluetoothManager.discoveredPeripherals, id: \.identifier) { peripheral in
        HStack {
          Text(peripheral.name ?? "Unknown Device")
          Spacer()
          Button("Connect") {
            bluetoothManager.connect(to: peripheral)
          }
          .foregroundColor(.blue)
        }
      }.background(.white)
    }
    .onChange(of: bluetoothManager.connectedPeripheral) { connectedPeripheral in
      if connectedPeripheral != nil {
        print("연결됨!")
      }
    }
    .padding()
  }
}