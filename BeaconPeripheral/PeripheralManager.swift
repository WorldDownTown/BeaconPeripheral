//
//  PeripheralManager.swift
//  BeaconPeripheral
//
//  Created by shoji on 2015/12/07.
//  Copyright © 2015年 com.shoji. All rights reserved.
//

import CoreBluetooth
import CoreLocation

class PeripheralManager: CBPeripheralManager {

    private static let sharedInstance = PeripheralManager()
    private let beaconIdentifier = ""
    private let uuidString = ""

    /**
     ペリフェラルとしてアドバタイジングを開始する
     */
    static func startAdvertising() {
        // delegateに代入すると CBPeripheralManagerDelegate のメソッドが呼び出される
        sharedInstance.delegate = sharedInstance
    }
}


// MARK: - CBPeripheralManagerDelegate

extension PeripheralManager: CBPeripheralManagerDelegate {

    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .Unknown:
            print("Unknown")
        case .Resetting:
            print("Resetting")
        case .Unsupported:
            print("Unsupported")
        case .Unauthorized:
            print("Unauthorized")
        case .PoweredOff:
            print("PoweredOff")
        case .PoweredOn:
            print("PoweredOn")
            startAdvertisingWithPeripheralManager(peripheral)
        }
    }

    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        if let error = error {
            print("Failed to start advertising with error:\(error)")
        } else {
            print("Start advertising")
        }
    }

    /**
     ペリフェラルとしてアドバタイジングを開始する

     - parameter manager: CBPeripheralManagerDelegate から受け取れる CBPeripheralManager
     */
    private func startAdvertisingWithPeripheralManager(manager: CBPeripheralManager) {
        guard let proximityUUID = NSUUID(UUIDString: uuidString) else {
            return
        }

        let beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID, identifier: beaconIdentifier)
        let beaconPeripheralData: NSDictionary = beaconRegion.peripheralDataWithMeasuredPower(nil)
        manager.startAdvertising(beaconPeripheralData as? [String: AnyObject])
    }
}
