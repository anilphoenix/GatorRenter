//
//  DataTableViewCell.swift
//  GatorRenter
//
//  Created by fdai4856 on 15/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import UIKit

struct DataTableViewCellData {
    
    init(imageUrl: String, text: String) {
        self.imageUrl = imageUrl
        self.text = text
    }
    var imageUrl: String
    var text: String
}

class DataTableViewCell : BaseTableViewCell {
    
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!
    
    override func awakeFromNib() {
        self.dataText?.font = UIFont.italicSystemFont(ofSize: 16)
        self.dataText?.textColor = UIColor(hex: "9E9E9E")
    }
 
    override class func height() -> CGFloat {
        return 80
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? DataTableViewCellData {
            self.dataImage.setRandomDownloadImage(80, height: 80, query: "")
            self.dataText.text = data.text
        }
    }
}
