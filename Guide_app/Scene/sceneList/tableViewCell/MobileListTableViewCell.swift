//
//  SegmentTableViewCell.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import UIKit
import Kingfisher
class MobileListTableViewCell: UITableViewCell {
  
  var btnFavoriteAction: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  @IBOutlet weak var imagePhone: UIImageView!
  @IBOutlet weak var textBrand: UILabel!
  @IBOutlet weak var subText: UILabel!
  @IBOutlet weak var price: UILabel!
  @IBOutlet weak var rating: UILabel!
  @IBOutlet weak var btnFavorite: UIButton!
  
  var favCheck = false
  var imageCheck = StatusBar.self
  @IBAction func favorite(_ sender: Any) {
    btnFavoriteAction?()
    
  }
  func setUi(classPhone: Mobile, isFavourite: Bool){
    imagePhone.kf.setImage(with: URL(string: classPhone.thumbImageURL!))
    textBrand.text = classPhone.name
    subText.text = classPhone.phoneDescription
    price.text = "$\(classPhone.price ?? 0)"
    rating.text = "\(classPhone.rating ?? 0)"
    favCheck = isFavourite
    
    if isFavourite  {
      btnFavorite.setImage(UIImage(named: "starSuccess"), for: UIControl.State.normal)
      
    } else {
      btnFavorite.setImage(UIImage(named: "star"), for: UIControl.State.normal)
    }
  }
  func setFavHidden(isMenuFavorite: StatusBar){
    
    if isMenuFavorite == .favorite{
      btnFavorite.isHidden = true
    }else if isMenuFavorite == .all{
      btnFavorite.isHidden = false
      
    }
  }
}
