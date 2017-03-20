//
//  CollectionViewCell.swift
//  GatorRenter
//
//  Created by fdai4856 on 15/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var RentNowButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 8.0
//        self.contentView.layer.borderWidth = 1.0
//        self.contentView.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

}
