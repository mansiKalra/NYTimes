//
//  DetailViewController.swift
//  NYTimes
//
//  Created by KiwiTech on 15/11/18.
//  Copyright © 2018 KiwiTech. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var datailLabel: TDLabel!
    var topHeaderView = NavigationView()
    var artDescription = ""
    var artImage = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        addHeader()
        datailLabel.text = artDescription
        let imageURL = URL(string:artImage)

        let loadedImageData = NSData(contentsOf: imageURL as! URL)
        DispatchQueue.main.async {
                if let imageData = loadedImageData  {
                    self.articleImageView?.image = UIImage(data: imageData as Data)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topHeaderView.leftBtn.isHidden = false

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        topHeaderView.leftBtn.isHidden = true
    }

    func addHeader() {
        topHeaderView = NavigationView.instanceFromNib() as! NavigationView
        topHeaderView.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: kHeaderHeight + 20)
        topHeaderView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        topHeaderView.leftBtn.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        topHeaderView.leftBtn.isHidden = false
        self.view.addSubview(topHeaderView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController {
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
}
}
