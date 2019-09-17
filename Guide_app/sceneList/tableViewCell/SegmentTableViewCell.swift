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
    var imageCheck = 0
    @IBAction func favorite(_ sender: Any) {
        
        if  imageCheck == 0 {
        imageFavorite.setImage(UIImage(named: "starSuccess"), for: UIControl.State.normal)
            imageCheck = 1
        }else if imageCheck == 1{
            imageFavorite.setImage(UIImage(named: "star"), for: UIControl.State.normal)
            imageCheck = 0
        }
        
    }
    
    func setUi(classPhone: phone){
        imagePhone.kf.setImage(with: URL(string: classPhone.thumbImageURL))
        textBrand.text = classPhone.brand
        subText.text = classPhone.phoneDescription
        price.text = "\(classPhone.price)"
        rating.text = "\(classPhone.rating)"
        
    }
}
