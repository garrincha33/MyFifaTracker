//
//  CreateTeamController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 01/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

class CreateTeamController: UIViewController {
    
    let nameLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.text = "Name"
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Team Name"
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightRedBackGround
        navigationItem.title = "Create Team"
        setupNavBarStyle()
        setupUI()
    }
    
    fileprivate func setupUI() {
        let lightRedBackgroundView = UIView()
        lightRedBackgroundView.backgroundColor = .cellRed
        lightRedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightRedBackgroundView)
        lightRedBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        lightRedBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightRedBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightRedBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameLable)
        nameLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLable.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLable.rightAnchor, constant: 10).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLable.bottomAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
