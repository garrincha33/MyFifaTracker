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
    
    func setupLightRedBackGroundView(height: CGFloat) -> UIView {
        
        let lightRedBackgroundView = UIView()
        lightRedBackgroundView.backgroundColor = .cellRed
        lightRedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightRedBackgroundView)
        lightRedBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        lightRedBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightRedBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightRedBackgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return lightRedBackgroundView
        
    }

}
