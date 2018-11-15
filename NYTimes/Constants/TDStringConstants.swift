//
//  TDStringConstants.swift
//  iHiretech
//
//  Created by kiwitech on 08/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

// MARK: Alert
struct TDAlertStrings {
    static let kRequestTimeOut     = "Network connection is unstable. Please try again when connection is stronger."
    static let kAppName = "NYTimes"
    static let KAlertNoNetworkMsg     = "Internet connection appears to be offline."
    static let kAlertHeader           = ""
    static let kAlertOk               = "OK"
    static let kAlertConfirm               = "Confirm"
    static let kAlertTimeOut     = "Request time out."
    static let kAlertSomethingWentWrong = "Something went wrong. Please try again in sometime."

}

struct TDUrlString {
    static let kDevServer            = "http://api.nytimes.com/svc"
    static let kBaseURL              = kDevServer
    static let kServer               = kBaseURL + "/"
    static let APIKEY                    = "869d4e276804463b8b139a47809a8e4f"
    static let kDashBorad = kServer + "mostpopular/v2/mostviewed/all-sections/7.json?api-key=%@"


}
struct ErrorResult {
    static let kBadRequest   = 400
    static let kUnauthorised = 401
    static let kDeactivated = 423
    static let kSearchExceeded = 403
    static let kUnAvailable = 404
    static let kUnProcessableEntity = 422
    static let kConflict = 409
}
