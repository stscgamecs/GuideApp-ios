//
//  SegmentTableViewCell.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import UIKit

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
    
    
    func setUi(){
        
    }
}
