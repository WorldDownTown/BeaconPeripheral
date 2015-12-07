//
//  AppDelegate.swift
//  BeaconPeripheral
//
//  Created by shoji on 2015/12/07.
//  Copyright © 2015年 com.shoji. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        PeripheralManager.startAdvertising()

        return true
    }
}
