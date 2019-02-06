//
//  CreateTeamController.swift
//  MyFifaTracker
//
//  Created by Richard Price on 01/02/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit
import CoreData

protocol createTeamControllerDelegate {
    func addTeam(team: Teams)
    func editTeam(team: Teams)
}

class CreateTeamController: UIViewController {
    
    var delegate: createTeamControllerDelegate?
    
    var team: Teams? {
        didSet {
            nameTextField.text = team?.name
        }
    }
    
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = team == nil ? "Create Team" : "Edit Team"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightRedBackGround
        navigationItem.title = "Create Team"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        setupNavBarStyle()
        setupUI()
    }
    
    @objc fileprivate func handleSave() {
        print("test save button")
        if team == nil {
            createTeam()
        } else {
            saveTeamChanges()
        }
  
    }
    
    @objc fileprivate func handleCancel() {
        print("test cancel button")
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func saveTeamChanges() {
        let context = CoreDataManager.shared.persistantContainer.viewContext
        team?.name = nameTextField.text
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.editTeam(team: self.team!)
            }
        } catch let err {
            print("unable to edit team save", err)
        }
    }
    
    fileprivate func detectDevice() {
        
    }
    
    fileprivate func createTeam() {
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let team = NSEntityDescription.insertNewObject(forEntityName: "Teams", into: context)
        team.setValue(nameTextField.text, forKey: "name")
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.addTeam(team: team as! Teams)
            }
            
        } catch let err {
            print("failed to load context", err)
        }
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
