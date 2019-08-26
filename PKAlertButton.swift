//
//  PKAlertButton.swift
//
//
//  Created by Pramod Kumar on 16/01/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import UIKit

open class PKAlertButton {
    
    var title: String = ""
    var titleColor: UIColor = .black
    var titleFont: UIFont = UIFont.systemFont(ofSize: 20.0)
    
    init(title: String = "", titleColor: UIColor = .black, titleFont: UIFont = AppFonts.Regular.withSize(20.0)) {
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
    }
}
