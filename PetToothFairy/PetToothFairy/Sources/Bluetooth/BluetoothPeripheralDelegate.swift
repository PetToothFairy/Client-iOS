//
//  BluetoothPheripheralDelegate.swift
//  PetToothFairy
//
//  Created by 임주민 on 11/20/24.
//

import Foundation
import CoreBluetooth

class BluetoothPeripheralDelegate: NSObject, CBPeripheralDelegate {
    var onSensorValueUpdate: (String) -> Void

    init(onSensorValueUpdate: @escaping (String) -> Void) {
        self.onSensorValueUpdate = onSensorValueUpdate
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.properties.contains(.notify) {
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value, let value = String(data: data, encoding: .utf8) {
            onSensorValueUpdate(value)
        }
    }
}
