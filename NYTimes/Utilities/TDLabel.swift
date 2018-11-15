//
//  TDLabel.swift
//  iHiretech
//
//  Created by kiwitech on 08/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TDLabel : UILabel {
    @IBInspectable internal var attributed : Bool = true
    @IBInspectable internal var underlined : Bool = false
    @IBInspectable internal var characterSpace : Float = 0.0
    @IBInspectable internal var lineSpace : CGFloat = 0.0
    override  open func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    func setup() {
        self.font  =  UIFont(name: (self.font?.fontName)!, size: (self.font.pointSize)*screenScaleFactor)
    }
    override open var text: String? {
        didSet {
            if text != nil {
                if attributed {
                   // setAttributedLabel()
                }
            }
        }
    }
    func setAttributedLabel() {
        let stringArributes: [NSAttributedString.Key: Any] = [
            .strokeColor : self.textColor,
            .font : self.font
        ]
        // let stringArributes = [ kCTFontAttributeName : self.font,kCTForegroundColorAttributeName : self.textColor,] as [NSAttributedString : Any]
        if let data = text?.data(using: .utf8) {
            do {
                let attr = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                        .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
                self.attributedText = NSAttributedString(string: attr.string, attributes: stringArributes)
            } catch {
            }
        }
    }
}
extension UILabel {
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight: Int = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
}
