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

class CreateTeamController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var delegate: createTeamControllerDelegate?
    
    var team: Teams? {
        didSet {
            nameTextField.text = team?.name
            guard let created = team?.created else {return}
            datePicker.date = created
            
            if let imageData = team?.imageData {
                addImage.image = UIImage(data: imageData)
                setCicleImage()
            }
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
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.setValue(UIColor.white, forKey: "textColor")
        return dp
    }()
    
    lazy var addImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "camera"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFit
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return image
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
        team?.created = datePicker.date
        if let teamImage = addImage.image {
            let imageData = teamImage.jpegData(compressionQuality: 0.8)
            team?.imageData = imageData
        }
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.editTeam(team: self.team!)
            }
        } catch let err {
            print("unable to edit team save", err)
        }
    }

    fileprivate func createTeam() {
        let context = CoreDataManager.shared.persistantContainer.viewContext
        let team = NSEntityDescription.insertNewObject(forEntityName: "Teams", into: context)
        team.setValue(nameTextField.text, forKey: "name")
        team.setValue(datePicker.date, forKey: "created")
        
        if let teamImage = addImage.image {
            let imageData = teamImage.jpegData(compressionQuality: 0.8)
            team.setValue(imageData, forKey: "imageData")
        }
        
        
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.addTeam(team: team as! Teams)
            }
            
        } catch let err {
            print("failed to load context", err)
        }
    }
    
    fileprivate func setCicleImage() {
        addImage.layer.cornerRadius = addImage.frame.width / 2
        addImage.clipsToBounds = true
        addImage.layer.borderColor = UIColor.white.cgColor
        addImage.layer.borderWidth = 2
    }
    
    @objc fileprivate func handleSelectPhoto() {
        print("trying to select photo")
        let imagepickerController = UIImagePickerController()
        imagepickerController.delegate = self
        imagepickerController.allowsEditing = true
        present(imagepickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            addImage.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            addImage.image = originalImage
        }
        setCicleImage()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    fileprivate func setupUI() {
        let lightRedBackgroundView = UIView()
        lightRedBackgroundView.backgroundColor = .cellRed
        lightRedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lightRedBackgroundView)
        lightRedBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        lightRedBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightRedBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightRedBackgroundView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        view.addSubview(addImage)
        addImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        addImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameLable)
        nameLable.topAnchor.constraint(equalTo: addImage.bottomAnchor).isActive = true
        nameLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLable.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLable.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLable.topAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLable.rightAnchor, constant: 10).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLable.bottomAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: nameLable.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightRedBackgroundView.bottomAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        
        
    }
    
}
