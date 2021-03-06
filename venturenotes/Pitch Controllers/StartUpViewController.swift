//
//  StartUpViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let navigationTitle = String.startUpVCTitle

class StartUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = navigationTitle
        
        setUpNavBar()
        setUpViews()
        
        hideKeyboardWhenTapped()
    }
    
    var dealController: DealController?

    let cardView: UIView = {
        let cView = UIView()
        cView.layer.borderColor = UIColor.white.cgColor
        cView.layer.borderWidth = 1.0
        cView.layer.cornerRadius = 10
        cView.backgroundColor = .black
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.nameTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let startUpTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.startUpTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let websiteTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.websiteTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let contactTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 22)
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.contactTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let pitchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.pitchButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(pitchButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func pitchButtonTapped(sender: UIButton) {
        if nameTextField.text!.isEmpty || startUpTextField.text!.isEmpty || websiteTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please enter all fields correctly", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            
            guard let name = nameTextField.text, let startUp = startUpTextField.text, let website = websiteTextField.text, let contact = contactTextField.text else { return }
            
            dealController?.createDeal(with: startUp, name: name, product: website, contact: contact, date: Date())
        }
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    private func setUpNavBar() {
        let left = UIButton(type: .custom)
        left.setTitle(String.backButton, for: .normal)
        left.setTitleColor(.white, for: .normal)
        left.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        left.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        left.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        left.adjustsImageWhenHighlighted = false
        left.addTarget(self, action: #selector(leftBarButtonTapped(sender:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: left)
    }
    
    @objc private func leftBarButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpViews() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        view.addSubview(cardView)
        view.addSubview(startUpTextField)
        view.addSubview(nameTextField)
        view.addSubview(websiteTextField)
        view.addSubview(contactTextField)
        view.addSubview(pitchButton)
        
        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 275).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        startUpTextField.topAnchor.constraint(equalTo: nameTextField.topAnchor, constant: 50).isActive = true
        startUpTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startUpTextField.widthAnchor.constraint(equalToConstant: 275).isActive = true
        startUpTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        websiteTextField.topAnchor.constraint(equalTo: startUpTextField.topAnchor, constant: 50).isActive = true
        websiteTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        websiteTextField.widthAnchor.constraint(equalToConstant: 275).isActive = true
        websiteTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        contactTextField.topAnchor.constraint(equalTo: websiteTextField.topAnchor, constant: 50).isActive = true
        contactTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contactTextField.widthAnchor.constraint(equalToConstant: 275).isActive = true
        contactTextField.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        pitchButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 50).isActive = true
        pitchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pitchButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        pitchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
