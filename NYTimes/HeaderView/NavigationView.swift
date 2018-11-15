//
//  NavigationView.swift
//  NYTimes
//
//  Created by KiwiTech on 14/11/18.
//  Copyright © 2018 KiwiTech. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    @IBOutlet weak var leftBtn: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    class func instanceFromNib() -> UIView {
        let xib : NSArray = Bundle.main.loadNibNamed(CustomViewName.kHeaderView, owner: self, options: nil)! as NSArray
        return xib.object(at: 0) as! UIView
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }



    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
