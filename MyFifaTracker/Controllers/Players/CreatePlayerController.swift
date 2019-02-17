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
    
    let positionLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.text = "Position"
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let positionTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Player Position"
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
        guard let position = positionTextField.text else {return}
        guard let team = self.team else {return}
        
        if position.isEmpty || name.isEmpty {
            showAlert(title: "Oooops your missing some information", message: "you havent entered a name and player position")
            return
        }
        let tuplePlayerError = CoreDataManager.shared.savePlayer(name: name, team: team, position: position)
        
        if let error = tuplePlayerError.1 {
            print(error)
        } else {
            dismiss(animated: true) {
                self.delegate?.didAddPlayer(player: tuplePlayerError.0!)
            }
        }
    }
    
    fileprivate func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
        return
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
        
        view.addSubview(positionLable)
        positionLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor).isActive = true
        positionLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        positionLable.widthAnchor.constraint(equalToConstant: 100).isActive = true
        positionLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(positionTextField)
        positionTextField.topAnchor.constraint(equalTo: positionLable.topAnchor).isActive = true
        positionTextField.leftAnchor.constraint(equalTo: positionLable.rightAnchor, constant: 10).isActive = true
        positionTextField.bottomAnchor.constraint(equalTo: positionLable.bottomAnchor).isActive = true
        positionTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
}
