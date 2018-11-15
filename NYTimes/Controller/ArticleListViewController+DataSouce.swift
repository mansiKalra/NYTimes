//
//  ArticleListViewController+DataSouce.swift
//  NYTimes
//
//  Created by KiwiTech on 13/11/18.
//  Copyright © 2018 KiwiTech. All rights reserved.
//

import Foundation
import UIKit

extension ArticleListViewController : UITableViewDelegate, UITableViewDataSource {
    internal func registerCell() {
        tblArticle.register(UINib(nibName : TDTableCellNibName.kAricleNib, bundle : nil), forCellReuseIdentifier:  TDTableCellNibName.kAricleNib)

    }
    internal func configureTableView() {
        registerCell()
        tblArticle.estimatedRowHeight = 1000
        tblArticle.rowHeight = UITableView.automaticDimension


    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleDataArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblArticle.dequeueReusableCell(withIdentifier: TDTableCellNibName.kAricleNib, for: indexPath) as?
            ArticleTableViewCell {
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            self.configurelistCell(cell:cell, indexPath:indexPath)
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nxtVC = StoryboardCoordinator.loadDetailViewController()
        guard nxtVC != nil else { return }
        let cellModel = articleDataArr?[indexPath.row]
        nxtVC?.artDescription = cellModel!.articleDescription
        nxtVC?.artImage = cellModel!.articleImage
        self.navigationController?.pushViewController(nxtVC!, animated: true)
    }


    internal func configurelistCell(cell:ArticleTableViewCell, indexPath:IndexPath) {
        let cellModel = articleDataArr?[indexPath.row]
        cell.titleLabel.text = cellModel!.articleDescription
        cell.authorLabel.text = cellModel!.articleAuthor
        cell.dateLabel.text = cellModel!.articleDate

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }







}
