//
//  ArticleListViewController.swift
//  NYTimes
//
//  Created by KiwiTech on 13/11/18.
//  Copyright © 2018 KiwiTech. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON


class ArticleListViewController: UIViewController {
    var articleDataArr:[ArticleInfo]?
    var topHeaderView = NavigationView()
    @IBOutlet weak var tblArticle: UITableView!
    @IBOutlet weak var tblViewTopConstraints: NSLayoutConstraint!



    override func viewDidLoad() {
        super.viewDidLoad()
        addHeader() 
        configureTableView()
        getArticleDetail()
    }

    func addHeader() {
        topHeaderView = NavigationView.instanceFromNib() as! NavigationView
        topHeaderView.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: kHeaderHeight + 20)
        topHeaderView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
            tblViewTopConstraints.constant =  kHeaderHeight1
        self.view.addSubview(topHeaderView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topHeaderView.leftBtn.isHidden = true

    }

    func getArticleDetail() {
        if TDUtility.checkNetworkConection() {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            ArticleBL.getArticleData { (status, json, error) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.saveAllData(json)
                }
                if status {
                } else {
                    self.showAlertWithError(error)
                }
            }
        }
    }


    func showAlertWithError(_ error : TDError?) {
        if error?.statusCode == NSURLErrorTimedOut {
            TDUtility.showAlertViewController(onViewController: self, alertMsg: TDAlertStrings.kRequestTimeOut, withTitle: TDAlertStrings.kAppName)
        } else {
            TDUtility.showAlertViewController(onViewController: self, alertMsg: error?.description ?? "", withTitle: TDAlertStrings.kAppName)
        }
    }

    func saveAllData(_ listObj : JSON) {
        let listArr = listObj["results"].arrayValue
        articleDataArr = []
        for item in listArr {
            self.saveMessageData(item)
        }
        tblArticle.delegate = self
        tblArticle.dataSource = self
        tblArticle.reloadData()
    }

    func saveMessageData(_ recentMessageObj : JSON) {
        debugPrint(recentMessageObj)
        let articleDataDict = ArticleInfo()
        articleDataDict.articleTitle = recentMessageObj["title"].stringValue
        articleDataDict.articleAuthor = recentMessageObj["byline"].stringValue
        articleDataDict.articleDate = recentMessageObj["published_date"].stringValue
        articleDataDict.articleDescription = recentMessageObj["abstract"].stringValue
        let image = recentMessageObj["media"][0]["media-metadata"].arrayValue
        let url = image[0]["url"].stringValue
        articleDataDict.articleImage = url
        articleDataArr?.append(articleDataDict)
    }
}
