//
//  TDConstant.swift
//  iHiretech
//
//  Created by kiwitech on 08/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

let screenScaleFactor : CGFloat =  DeviceType.IS_IPAD ? 1 : UIScreen.main.bounds.size.width / 375.0
@available(iOS 10.0, *)
let appDelegate = UIApplication.shared.delegate as? AppDelegate

// MARK: Device Types & Size
struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0 || UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 320.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0  || UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 375.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0 ||  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 414.0
    static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0 &&  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 375.0
    static let IS_IPHONE_X_NEW_SERIES         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH >= 812.0 &&  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH >= 375.0
    static let IS_IPHONE_OTHER_SERIES       = DeviceType.IS_IPHONE_X ? 50 : (DeviceType.IS_IPHONE_X_NEW_SERIES ? 50 : 30)

    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
}
let deviceType = "IOS"
let kHeaderHeight : CGFloat = DeviceType.IS_IPHONE_X ? 64 : (DeviceType.IS_IPHONE_X_NEW_SERIES ? 74 : 44)
let kHeaderHeight1 : CGFloat = DeviceType.IS_IPHONE_X ? 44 : (DeviceType.IS_IPHONE_X_NEW_SERIES ? 54 : 64)



