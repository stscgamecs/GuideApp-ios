//
//  MobileListDetailCollectionViewCell.swift
//  Guide_app
//
//  Created by Z64me on 20/9/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import UIKit
var imageCache: [String: UIImage] = [:]
class MobileListDetailCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var mobileImage: UIImageView!
  
  func setUiCollectionView(classImage: ImageMobile) {
    
    if let image = imageCache[classImage.url]{
      mobileImage.image = image
    }else if let url = URL(string: classImage.url) {
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          imageCache[classImage.url] = image
          self.mobileImage.image = image
        }
      }
      
    }
    //mobileImage.image = imageURL
  }
  
}
