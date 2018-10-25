//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by Isaacs, Todd (CAI - Carmel) on 9/30/18.
//  Copyright © 2018 Isaacs, Todd. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    let image = #imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal)
    button.setImage(image, for: .normal)
    
    button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
    return button
  }()
  
  let emailTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Email"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = .systemFont(ofSize: 14)
    
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let usernameTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Username"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = .systemFont(ofSize: 14)
    
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let passwordTextField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Password"
    tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
    tf.borderStyle = .roundedRect
    tf.font = .systemFont(ofSize: 14)
    tf.isSecureTextEntry = true
    
    tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    return tf
  }()
  
  let signUpButton:UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    button.layer.cornerRadius = 5
    
    button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
    
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
  
  @objc fileprivate func handleTextInputChange() {
    let hasInput = emailTextField.text?.count ?? 0 > 0 &&
                    passwordTextField.text?.count ?? 0 > 0 &&
                    usernameTextField.text?.count ?? 0 > 0
    
    if hasInput {
      signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    } else {
      signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
    }
  }

  @objc fileprivate func handlePlusPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = true
    
    present(imagePickerController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
    let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
    
    if let image = editedImage {
      plusPhotoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    } else if let originalImage = originalImage {
      plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
    plusPhotoButton.layer.masksToBounds = true
    plusPhotoButton.layer.borderColor = UIColor.black.cgColor
    plusPhotoButton.layer.borderWidth = 3
    
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc fileprivate func handleSubmit() {
    guard let email = emailTextField.text, email.count > 0 else {
      return
    }
    guard let username = usernameTextField.text, username.count > 0 else {
      return
    }
    guard let password = passwordTextField.text, password.count > 0 else {
      return
    }
    

    Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error: Error?) in
      if let error = error {
        print("Error \(error.localizedDescription)")
      }
      
      print("Success, created user:", user?.uid ?? "")
      guard let image = self.plusPhotoButton.imageView?.image else {
        return
      }
      
      guard  let uploadData = UIImageJPEGRepresentation(image, 0.3)   else {
        return
      }
      let filename = NSUUID().uuidString
      
      Storage.storage().reference().child("profile_images").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err) in
        if let err = err {
          print("failed to upload profile iamge:", err)
          return
        }
        
        guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
        
        print("Successfully uploaded profile image:", profileImageUrl)
        if let user = user {
          
          let dictionaryValues = ["username" : username, "profileImageUrl": profileImageUrl]
          let values = [user.uid: dictionaryValues]
          
          Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
            if let error = error {
              print("Failed to save user info into db:", error)
              return
            }
            
            print("Successfully saved user info to db")
          })
        }
      })
      
    }
  }
}

