//
//  TeamsCustomCell.swift
//  MyFifaTracker
//
//  Created by Richard Price on 14/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

class TeamsCustomCell: UITableViewCell {
    
    let teamImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .cellRed

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
