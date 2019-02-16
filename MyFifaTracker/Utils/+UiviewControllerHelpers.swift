//
//  +UiviewControllerHelpers.swift
//  MyFifaTracker
//
//  Created by Richard Price on 16/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

extension UIViewController {
    //helpers
    func setupNavControllerButtonsInNavBar(selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus1"), style: .plain, target: self, action: selector)
    }

}
