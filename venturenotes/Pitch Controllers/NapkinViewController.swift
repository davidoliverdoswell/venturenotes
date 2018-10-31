//
//  NapkinViewController.swift
//  venturenotes
//
//  Created by David Doswell on 10/30/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let navigationTitle = String.napkinVCTitle

class NapkinViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = navigationTitle
        
        setUpNavBar()
        setUpViews()
        
        hideKeyboardWhenTapped()
        
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    var napkin: Napkin?
    var napkinController: NapkinController?
    
    let cardView: UIView = {
        let cView = UIView()
        cView.layer.borderColor = UIColor.white.cgColor
        cView.layer.borderWidth = 1.0
        cView.layer.cornerRadius = 10
        cView.backgroundColor = .black
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.tintColor = .white
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.titleTextFieldTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.tintColor = .black
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date = Date()
    let formatter = DateFormatter()
    
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
        if titleTextField.text!.isEmpty || descriptionTextView.text.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please enter all fields correctly", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            guard let title = titleTextField.text, let description = descriptionTextView.text else { return }
            
            napkinController?.createNote(title: title, description: description, date: Date())
        }
        presentDealFlowVC()
    }
    
    private func presentDealFlowVC() {
        let vc = DealViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func cancelButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
        view.backgroundColor = UIColor(patternImage: UIImage(named: "NapkinBackground")!)
        
        view.addSubview(cardView)
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(dateLabel)
        view.addSubview(pitchButton)
        
        titleTextField.delegate = self
        
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        dateLabel.text = formatter.string(from: date)
        
        cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        titleTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        titleTextField.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30).isActive = true
        descriptionTextView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        descriptionTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        pitchButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 50).isActive = true
        pitchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pitchButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        pitchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
