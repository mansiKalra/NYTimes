//
//  ArticleBL.swift
//  NYTimes
//
//  Created by KiwiTech on 13/11/18.
//  Copyright © 2018 KiwiTech. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleBL: NSObject {

    class func getArticleData(completion : @escaping (_ isSuccess : Bool, _ response : JSON, _ error :TDError?) -> Void) {
        let urlStr = String(format:TDUrlString.kDashBorad, arguments: [TDUrlString.APIKEY])
        AFWrapper.getRequest(urlString: urlStr, requestMethod: .get, headers: nil, params: nil, success: { (JSON) in
            debugPrint(JSON)
            completion(true, JSON, nil)
        }) { (error) in
            debugPrint (error)
            completion(false, nil, error)
        }
    }

}
