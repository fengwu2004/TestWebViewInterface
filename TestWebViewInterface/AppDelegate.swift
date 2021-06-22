//
//  AppDelegate.swift
//  TestWebViewInterface
//
//  Created by admin on 2021/4/24.
//

import UIKit
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("idfa", ASIdentifierManager.shared().advertisingIdentifier.uuidString)
        
        print("idfv", UIDevice.current.identifierForVendor?.uuidString)

        return true
    }
}

