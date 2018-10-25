//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by Isaacs, Todd (CAI - Carmel) on 10/10/18.
//  Copyright © 2018 Isaacs, Todd. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.backgroundColor = .white
    
    fetchUser()
    
    collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
    
    //header.backgroundColor = .green
    
    return header
  }
  
  
  //Size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 200)
  }
  
  fileprivate func fetchUser() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
      print(snapshot.value ?? "")
      guard let dictionay = snapshot.value as? [String: Any] else { return }
      let username = dictionay["username"] as? String
      self.navigationItem.title = username
    }) { (err) in
      print("Failed to fetch user:", err)
    }
  }
}
