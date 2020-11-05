//
//  Item.swift
//  HitsManager
//
//  Created by LTT on 11/5/20.
//

import Foundation
import UIKit

class Item {
    let id: Int
    let image: UIImage
    var didSellected = false
    
    init() {
        id = 0
        image = UIImage()
    }
    
    init(id: Int, image: UIImage) {
        self.id = id
        self.image = image
    }
}
