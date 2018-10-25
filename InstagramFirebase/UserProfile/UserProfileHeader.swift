//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by Isaacs, Todd (CAI - Carmel) on 10/18/18.
//  Copyright © 2018 Isaacs, Todd. All rights reserved.
//

import UIKit

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
    URLSession.shared.dataTask(with: <#T##URL#>) { (data, response, err) in
      //
    }
  }
}
