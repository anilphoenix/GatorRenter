//
//  UIView.swift
//  GatorRenter
//
//  Created by fdai4856 on 15/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
}
