//
//  CreatePlayerController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 16/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit

protocol createPlayerControllerDelegate {
    func didAddPlayer(player: Players)
}

class CreatePlayerController: UIViewController {
    
    var team: Teams?
    var delegate: createPlayerControllerDelegate?
    
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
        navigationItem.title = "Add Player"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(handleCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "save"), style: .plain, target: self, action: #selector(handleSavePlayer))
        _ = setupLightRedBackGroundView(height: 150)
        setupUI()
    }
    
    @objc fileprivate func handleCancelButton() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc fileprivate func handleSavePlayer() {
        guard let name = nameTextField.text else {return}
        guard let team = self.team else {return}
 
        let tuplePlayerError = CoreDataManager.shared.savePlayer(name: name, team: team)
        
        if let error = tuplePlayerError.1 {
            print(error)
        } else {
            dismiss(animated: true) {
                self.delegate?.didAddPlayer(player: tuplePlayerError.0!)
            }
        }
    }
    
    fileprivate func setupUI() {
        view.addSubview(nameLable)
        nameLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLable.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLable.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLable.rightAnchor, constant: 10).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLable.bottomAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
}
