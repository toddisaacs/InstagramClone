//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by Isaacs, Todd (CAI - Carmel) on 9/30/18.
//  Copyright © 2018 Isaacs, Todd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    let image = #imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal)
    button.setImage(image, for: .normal)
    
    return button
  }()
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Email"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = .systemFont(ofSize: 14)
    
    return tf
  }()
  
  let usernameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Username"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = .systemFont(ofSize: 14)
    
    return tf
  }()
  
  let passwordTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Password"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = .systemFont(ofSize: 14)
    tf.isSecureTextEntry = true
    
    return tf
  }()
  
  let signUpButton:UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    button.layer.cornerRadius = 5
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    view.addSubview(plusPhotoButton)
    plusPhotoButton.anchor(top: view.topAnchor,
                           left: nil,
                           bottom: nil,
                           right: nil,
                           paddingTop: 40,
                           paddingLeft: 0,
                           paddingBottom: 0,
                           paddingRight: 0,
                           width: 140,
                           height: 140)
    plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    
    setupInputFields()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  fileprivate func setupInputFields() {
    let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signUpButton])
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .fillEqually
    stackView.axis = .vertical
    stackView.spacing = 10
    
    view.addSubview(stackView)
    
    stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20).isActive = true
    stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
    stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
    stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
  }

}

