//
//  SegmentTableViewCell.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import UIKit
import Kingfisher
class SegmentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var imagePhone: UIImageView!
    @IBOutlet weak var textBrand: UILabel!
    @IBOutlet weak var subText: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var imageFavorite: UIButton!
    //let imageCheck = UIImage(named: "star")
    var imageCheck = false
    @IBAction func favorite(_ sender: Any) {
        
        if  imageCheck == false {
        imageFavorite.setImage(UIImage(named: "starSuccess"), for: UIControl.State.normal)
            imageCheck = true
        }else if imageCheck == true{
            imageFavorite.setImage(UIImage(named: "star"), for: UIControl.State.normal)
            imageCheck = false
        }
        
    }
    
    func setUi(classPhone: Mobile){
        imagePhone.kf.setImage(with: URL(string: classPhone.thumbImageURL!))
        textBrand.text = classPhone.name
        subText.text = classPhone.phoneDescription
      price.text = "\(classPhone.price ?? 0)"
      rating.text = "\(classPhone.rating ?? 0)"
        
    }
}
