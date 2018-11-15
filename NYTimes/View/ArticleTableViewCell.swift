//
//  ArticleTableViewCell.swift
//  NYTimes
//
//  Created by KiwiTech on 13/11/18.
//  Copyright © 2018 KiwiTech. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: TDLabel!
    @IBOutlet weak var authorLabel: TDLabel!
    @IBOutlet weak var dateLabel: TDLabel!
    @IBOutlet weak var articleImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        articleImageView.layer.cornerRadius = self.articleImageView.frame.size.width * 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
