//
//  TDUtility.swift
//  iHiretech
//
//  Created by kiwitech on 08/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreTelephony
import MobileCoreServices
import AVFoundation
import Photos
import AVKit
import AssetsLibrary
import SwiftyJSON
import MapKit

class TDUtility {
    // MARK: Method To ChangeFontSize
    //________________________ Alert ________________________//
    class func showAlertViewController(onViewController:UIViewController, alertMsg:String, withTitle:String) {
        let alert = UIAlertController(title: withTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: TDAlertStrings.kAlertOk, style: UIAlertAction.Style.default, handler: nil))
        onViewController.present(alert, animated: true, completion: nil)
    }
    //This method checks user current location permission is enable or not on first time app launch
   class func checkNetworkConection() -> Bool {
            if TDReachability.isNetworkConnected() {
                return true
            }
            return false
        }

    class func controllerForClass(name: String,  storyBoardName:String) -> UIViewController {
        let identifier: String  = name
        let viewController:UIViewController = UIStoryboard(name: storyBoardName , bundle: nil).instantiateViewController(withIdentifier: identifier as String) as UIViewController
        return viewController
    }

    static func setObjectInUserDefaults(setObject:Any, forKey:String) {
        //Set Object
        UserDefaults.standard.set(setObject, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    static func removeObjectFromUserDefaultsfor(defaultsKey:String) {
        //Set Object
        UserDefaults.standard.removeObject(forKey: defaultsKey)
        UserDefaults.standard.synchronize()
    }
    static func getObjectFromUserDefaults(forKey:String)->Any? {
        //Get Object
        if let object  = UserDefaults.standard.object(forKey: forKey) {
            return object as AnyObject?
        } else {
            return nil
        }
    }



    
}
