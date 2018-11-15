//
//  StoryboardCoordinator.swift
//  iHiretech
//
//  Created by KiwiTech on 18/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

class StoryboardCoordinator {
    //load signupViewController
    class func loadDetailViewController() -> DetailViewController? {
        let detailVC = TDUtility.controllerForClass(name: ControllerName.kDetailController, storyBoardName:StoryBoardName.kdetail) as! DetailViewController
        return detailVC
    }
}
