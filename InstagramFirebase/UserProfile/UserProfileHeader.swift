//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by Isaacs, Todd (CAI - Carmel) on 10/18/18.
//  Copyright © 2018 Isaacs, Todd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UserProfileHeader: UICollectionViewCell {
  
  let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .red
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .blue
    addSubview(profileImageView)
    profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
    
    profileImageView.layer.cornerRadius = 80 / 2
    profileImageView.clipsToBounds = true
    
    setupProfileImage()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    
   
  fileprivate func setupProfileImage() {
    //get image
    guard let uid = Auth.auth().currentUser?.uid else {
        return
    }
    
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
        print(snapshot.value ?? "")
        guard let dictionay = snapshot.value as? [String: Any] else { return }
        //let username = dictionay["username"] as? String
        guard let profileImageUrl = dictionay["profileImageUrl"] as? String else { return }
        
        //build image
        guard let url = URL(string: profileImageUrl) else { return }
      
        URLSession.shared.dataTask(with: url) { (data, response, err) in
              //check error and build image
              guard let data = data else { return }
              let image = UIImage(data: data)
          
              //render on the main thread
              DispatchQueue.main.async {
                self.profileImageView.image = image
              }
          
            }.resume()

    }) { (err) in
        print("Failed to fetch user:", err)
    }
    
    
  }
}
