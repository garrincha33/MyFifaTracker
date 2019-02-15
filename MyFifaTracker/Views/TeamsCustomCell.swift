//
//  TeamsCustomCell.swift
//  MyFifaTracker
//
//  Created by Richard Price on 14/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

class TeamsCustomCell: UITableViewCell {
    
    var team: Teams? {
        didSet {
            print(team?.name ?? "")
            teamNameCreatedLable.text = team?.name
            
            if let imageData = team?.imageData {
                teamImage.image = UIImage(data: imageData)
            }
            
            if let t = team?.name, let created = team?.created {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MM yyyy"
                let createdString = dateFormatter.string(from: created)
                let dateString = "\(t): created, \(createdString)"
                teamNameCreatedLable.text = dateString
            } else {
                teamNameCreatedLable.text = team?.name
            }
        }
    }
    
    let teamImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "select_photo_empty"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let teamNameCreatedLable: UILabel = {
        let lable = UILabel()
        lable.text = "Team Name"
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .white
        return lable
    }()
    
    let roundedCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cellRed
        view.clipsToBounds = true
        //layers
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
        //borders
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightRedBackGround
        
        addSubview(roundedCellView)
        roundedCellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        roundedCellView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        roundedCellView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        roundedCellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(teamImage)
        teamImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        teamImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        teamImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        teamImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 4).isActive = true
        
        addSubview(teamNameCreatedLable)
        teamNameCreatedLable.leftAnchor.constraint(equalTo: teamImage.rightAnchor, constant: 8).isActive = true
        teamNameCreatedLable.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        teamNameCreatedLable.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        teamNameCreatedLable.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
