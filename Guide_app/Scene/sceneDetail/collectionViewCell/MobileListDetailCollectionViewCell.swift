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
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  func setUiCollectionView(classImage: String,classMobile: Mobile) {
    ratingLabel.text = "\(classMobile.rating ?? 0)"
    priceLabel.text = "\(classMobile.price ?? 0)"
   let  urlString = classImage
    if let image = imageCache[urlString]{
      mobileImage.image = image
    }
      
    else if let url = URL(string: urlString) {

      if let data = try? Data(contentsOf: url) {
        
        if let image = UIImage(data: data) {
          
          imageCache[classImage] = image
          
          self.mobileImage.image = image
        }
      }
      
      
    }
      
    
    
  }
}
