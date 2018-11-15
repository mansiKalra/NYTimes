//
//  WebService.swift
//  SwiftyJSONAlamofire
//
//  Created by ALOK RANJAN TIWARI on 23/10/16.
//  Copyright © 2016 ALOK RANJAN TIWARI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class AFWrapper {
    static var reqestList:NSMutableSet = NSMutableSet()
     var manager:SessionManager?
    static let sharedInstance: AFWrapper = {
        let instance = AFWrapper()
        return instance
    }()
    func createSessionManager() {
        let configuration: URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            configuration.urlCache = nil
            return configuration
        }()
       //let configuration = URLSessionConfiguration.default
        //configuration.httpAdditionalHeaders = buildHeaders()
        let serverTrustPolicies: [String: ServerTrustPolicy] = ["login.hylofit.com": .disableEvaluation]
        manager = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        manager?.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    credential = self.manager?.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                    if credential != nil {
                        disposition = .useCredential
                    }
                }
            }
            return (disposition, credential)
        }
    }
    class func request(urlString : String, requestMethod : HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, params : [String : Any]?, isLoginAPI: Bool = false, success:@escaping (JSON) -> Void, failure:@escaping (TDError) -> Void) {
        Alamofire.request(urlString, method : .post, parameters: params, encoding: encoding, headers: headers).responseJSON { (response) -> Void in
            switch response.result {
            case .success(let value):
                let json = JSON.init(response.result.value!)
                let statusCode : Int = response.response?.statusCode ?? 0
                if statusCode == ErrorResult.kUnauthorised && isLoginAPI == false {
                } else if (200 ... 299).contains(statusCode) {
                    let json = JSON(value)
                    success(json)
                } else {
                    let hnError = TDError()
                    var messageDict  = [JSON]()
                    messageDict = json["msg"].array ?? [JSON]()
                    var errormessage = ""
                    if messageDict.count == 0 {
                        if let message = json["msg"].string {
                            errormessage = message
                        }
                    } else {
                        errormessage = messageDict[0]["errorMessage"].stringValue
                    }
                    if response.result.error == nil {
                        hnError.statusCode = statusCode
                        hnError.description = errormessage
                    } else {
                        hnError.statusCode = (response.response?.statusCode)!
                        hnError.description = ((response.result.error as NSError?)?.localizedDescription)!
                    }
                    failure(hnError)
                }
            case .failure(let error):
                let errorStatusCode = response.response?.statusCode ?? 0
                 let dnError = TDError()
                if errorStatusCode == ErrorResult.kUnauthorised {
                } else {
                    dnError.statusCode = errorStatusCode
                    if dnError.statusCode == 0 {
                        debugPrint(response)
                    }
                    dnError.description = error.localizedDescription
                    failure(dnError)
                }
            }
        }
    }
    // Delete Request
    func stopAllPrevioudRequest() {
        for req in AFWrapper.reqestList {
            (req as! DataRequest).suspend()
        }
        AFWrapper.reqestList.removeAllObjects()
    }
    func stopRequest(url:URL) {
        var dataReq:DataRequest? = nil
        for req in AFWrapper.reqestList {
            if (req as! DataRequest).request?.url == url {
                (req as! DataRequest).suspend()
                dataReq = (req as! DataRequest)
             break
            }
        }
        if let req = dataReq {
            AFWrapper.reqestList.remove(req)
        }
    }
    public class func cancelRequest() {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
        }
    }
    //Get API Request
    class func getRequest(urlString : String, requestMethod : HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, params : [String : Any]?, isLoginAPI: Bool = false, success:@escaping (JSON) -> Void, failure:@escaping (TDError) -> Void) {
        Alamofire.request(urlString, method : .get, parameters: params, encoding: encoding, headers: headers).responseJSON { (response) -> Void in
            switch response.result {
            case .success(let value):
                let json = JSON.init(response.result.value!)
                let statusCode : Int = response.response?.statusCode ?? 0
                if statusCode == ErrorResult.kUnauthorised && isLoginAPI == false {
                } else if (200 ... 299).contains(statusCode) {
                    let json = JSON(value)
                    success(json)
                } else {
                    let hnError = TDError()
                    var messageDict  = [JSON]()
                    messageDict = json["msg"].array ?? [JSON]()
                    var errormessage = ""
                    if messageDict.count == 0 {
                        if let message = json["msg"].string {
                            errormessage = message
                        }
                    } else {
                        errormessage = messageDict[0]["errorMessage"].stringValue
                    }
                    if response.result.error == nil {
                        hnError.statusCode = statusCode
                        hnError.description = errormessage
                    } else {
                        hnError.statusCode = (response.response?.statusCode)!
                        hnError.description = ((response.result.error as NSError?)?.localizedDescription)!
                    }
                    failure(hnError)
                }
            case .failure(let error):
                let errorStatusCode = response.response?.statusCode ?? 0
                  let dnError = TDError()
                if errorStatusCode == ErrorResult.kUnauthorised {
                } else {
                    dnError.statusCode = errorStatusCode
                    if dnError.statusCode == 0 {
                        debugPrint(response)
                    }
                    dnError.description = error.localizedDescription
                    failure(dnError)
                }
            }
        }
    }
    //Function for calling GooleAPI for Lat long
    class func getRequestGoogleAPI(urlString : String, requestMethod : HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, params : [String : Any]?, isLoginAPI: Bool = false, success:@escaping (JSON) -> Void, failure:@escaping (TDError) -> Void) {
        Alamofire.request(urlString, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON {  (response) -> Void in
            switch response.result {
            case .success(let value):
                if let receivedResults = response.result.value {
                    let json = JSON.init(receivedResults)
                    let status = json["status"].stringValue
                    if  status != "OK" {
                        let hnError = TDError()
                        let errormessage = TDAlertStrings.kAlertSomethingWentWrong  
                        if response.result.error == nil {
                            hnError.statusCode = 0
                            hnError.description = errormessage
                        } else {
                            hnError.statusCode = (response.response?.statusCode)!
                            hnError.description = ((response.result.error as NSError?)?.localizedDescription)!
                        }
                        failure(hnError)
                    } else {
                        let json = JSON(value)
                        success(json)
                    }
                }
            case .failure(let error):
                let errorStatusCode = response.response?.statusCode ?? 0
                let dnError = TDError()
                dnError.statusCode = errorStatusCode
                if dnError.statusCode == 0 {
                    debugPrint(response)
                }
                dnError.description = error.localizedDescription
                failure(dnError)
            }
        }
    }
//URLEncoding() ParameterEncoding = JSONEncoding.default
    class func requestPostApi(urlString : String, requestMethod : HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, params : [String : Any]?, isLoginAPI: Bool = false, success:@escaping (_ status:Bool?,_ jsonData:JSON?, _ error:TDError?) -> Void, failure:@escaping (_ status:Bool?,_ jsonData:JSON?, _ error:TDError?) -> Void) {
        Alamofire.request(urlString, method : requestMethod, parameters: params, encoding: encoding, headers: headers).responseJSON { (response) -> Void in
            switch response.result {
            case .success(let value):
                debugPrint(value)
                if (200 ... 299).contains(response.response?.statusCode ?? 0) {
                    let json = JSON(response.result.value!)
                   success(true, json, nil)
                } else {
                    if response.response?.statusCode == ErrorResult.kUnauthorised {
                        let hnError = TDError()
                        if response.result.error == nil {
                            hnError.statusCode = response.response?.statusCode ?? ErrorResult.kUnauthorised
                            hnError.description = TDAlertStrings.kAlertSomethingWentWrong
                        } else {
                            hnError.statusCode = response.response?.statusCode ?? ErrorResult.kBadRequest
                            hnError.description = ((response.result.error as NSError?)?.localizedDescription) ?? ""
                        }
                        failure(false, nil, hnError)
                    } else {
                        let hnError = TDError()
                        if let jsonObj = response.result.value {
                            let json = JSON.init(jsonObj)
                            let statusCode : Int = json["code"].intValue
                            var messageDict  = [JSON]()
                            messageDict = json["msg"].array ?? [JSON]()
                            let errormessage : String
                            if messageDict.count == 0 {
                                errormessage = json["msg"].string ?? ""
                            } else {
                                errormessage = messageDict[0]["errorMessage"].stringValue
                            }
                            if response.result.error == nil {
                                hnError.statusCode = statusCode
                                hnError.description = errormessage
                            } else {
                                hnError.statusCode = (response.response?.statusCode) ?? ErrorResult.kBadRequest
                                hnError.description = ((response.result.error as NSError?)?.localizedDescription) ?? ""
                            }
                            failure(false, nil, hnError)
                        }
                        hnError.statusCode = response.response?.statusCode ?? 0
                        hnError.description =  TDAlertStrings.kAlertSomethingWentWrong
                        failure(false, nil, hnError)
                    }
                }
            case .failure(let error):
                let errorStatusCode = response.response?.statusCode ?? 0
                 let dnError = TDError()
                if errorStatusCode == ErrorResult.kUnauthorised {
                    return
                } else {
                    dnError.statusCode = errorStatusCode
                    if dnError.statusCode == 0 {
                        debugPrint(response)
                    }
                    dnError.description = error.localizedDescription
                    failure(false, nil, dnError)
                }
            }
        }
    }
}
class TDError {
  var statusCode : Int = 0
  var description : String = TDAlertStrings.kAlertSomethingWentWrong //When error msg is empty
}
// AFManager
class AFManager: NSObject {
    var reqestList:NSMutableArray = NSMutableArray()
    var downloadReq:DownloadRequest?
    static let sharedInstance: AFManager = {
        let instance = AFManager()
        // setup code
        return instance
    }()

    func stopAllPrevioudRequest() {
        for req in self.reqestList {
            (req as! DataRequest).suspend()
        }
        self.reqestList.removeAllObjects()
    }
    func downloadFromUrl( _ url:String, progressHandler progressValue:@escaping(Double) -> Void, responseHandler handler:@escaping (Bool, URL?, NSError?) -> Void) {
        let url_url = URL.init(string:url)
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent((url_url?.lastPathComponent)!)
            return (documentsURL, [.removePreviousFile, .createIntermediateDirectories])
        }

      downloadReq = Alamofire.download(url, to: destination).downloadProgress(queue: DispatchQueue.main) { (progress) in
            progressValue(progress.fractionCompleted)
        }.response { (response) in
            if let destinationUrl = response.destinationURL {
                handler(true, destinationUrl, nil)
            } else {
                handler(false, nil, response.error as NSError?)
            }
        }
    }
}
