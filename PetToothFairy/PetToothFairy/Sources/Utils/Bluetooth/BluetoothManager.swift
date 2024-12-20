//
//  BluetoothManager.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/06.
//
import SwiftUI
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
  @Published var isBluetoothOn = true
  @Published var discoveredPeripherals: [CBPeripheral] = []
  @Published var connectedPeripheral: CBPeripheral?
  @Published var receivedData: String = "No Data"
  @Published var receivedDataArray: [String] = []
  private var customNames: [String: String] = [:]
  
  var centralManager: CBCentralManager?
  private var rssiTimer: Timer?
  
  override init() {
    super.init()
    self.centralManager = CBCentralManager(delegate: self, queue: nil)
  }

  // 주변 장치 검색 시작
  func startScanning() {
    if isBluetoothOn {
      centralManager?.scanForPeripherals(withServices: nil, options: nil)
      print("Manager Started scanning for peripherals...")
    } else {
      print("Manager Bluetooth is off. Cannot start scanning.")
    }
  }
  
  // 블루투스 연결
  func connect(to peripheral: CBPeripheral) {
    centralManager?.connect(peripheral, options: nil)
  }
  
  // 블루투스 연결 해제
  func disconnect() {
    guard let peripheral = connectedPeripheral else {
      print("No peripheral connected.")
      return
    }
    
    centralManager?.cancelPeripheralConnection(peripheral)
    print("Manager disconnected from \(peripheral.name ?? "Unknown").")
  }
  
  // 블루투스 상태 업데이트
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .poweredOn:
      if !isBluetoothOn {
        print("Manager Bluetooth is powered on.")
      }
      DispatchQueue.main.async {
        self.isBluetoothOn = true
      }
    case .poweredOff, .resetting, .unauthorized, .unsupported, .unknown:
      isBluetoothOn = false
      print("Manager Bluetooth is not available.")
    @unknown default:
      print("Manager Unknown Bluetooth state.")
    }
  }
  
  // 주변 장치 발견 시
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
    guard RSSI.intValue > -70 else {  // 신호 세기가 -70 dBm 이상인 경우만 추가
      return
    }
    
    // 이름이 존재하는 디바이스만 추가
    guard let name = peripheral.name, !name.isEmpty else {
      return
    }
    
    // 중복된 디바이스는 추가하지 않음
    if !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
      discoveredPeripherals.append(peripheral)
    }
  }
  
  // 블루투스 연결 성공
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    print("Manager Connected to \(peripheral.name ?? "Unknown").")
    peripheral.delegate = self
    peripheral.discoverServices(nil)
    connectedPeripheral = peripheral
    print(peripheral.state)
  }
  
  // 블루투스 연결 해제
  func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    if let error = error {
      print("Error disconnecting from peripheral: \(error.localizedDescription)")
      return
    }
    
    print("Manager disconnected from \(peripheral.name ?? "Unknown").")
    connectedPeripheral = nil
  }
  
  // 데이터 수신
  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    guard let value = characteristic.value else { return }
    if let stringValue = String(data: value, encoding: .utf8) {
      DispatchQueue.main.async {
        self.receivedData = stringValue
        print("👉 \(self.receivedData)")
        if !self.receivedData.isEmpty {
          self.receivedDataArray.append(self.receivedData)
        }
      }
    }
  }
  
  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    if let error = error {
      print("Error discovering characteristics: \(error.localizedDescription)")
      return
    }
    
    guard let characteristics = service.characteristics else { return }
    for characteristic in characteristics {
      print("Discovered characteristic: \(characteristic.uuid)")
      
      // 데이터 읽기 또는 알림 설정
      if characteristic.properties.contains(.read) {
        peripheral.readValue(for: characteristic)
      }
      
      if characteristic.properties.contains(.notify) {
        peripheral.setNotifyValue(true, for: characteristic)
      }
    }
  }
  
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    if let error = error {
      print("Error discovering services: \(error.localizedDescription)")
      return
    }
    guard let services = peripheral.services else { return }
    for service in services {
      print("Discovered service: \(service.uuid)")
      // 특성 검색
      peripheral.discoverCharacteristics(nil, for: service)
    }
  }
  
  // 블루투스 스캔을 중지
  func stopScanning() {
    centralManager?.stopScan()
    print("Manager Stopped scanning for peripherals.")
    print(receivedDataArray)
  }
}
