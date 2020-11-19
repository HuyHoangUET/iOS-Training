//
//  Size.swift
//  HitsManager
//
//  Created by LTT on 19/11/2020.
//

import Foundation
import UIKit

let numberOfItemsInRow = 3
let paddingSpace: CGFloat = 12
let screenWidth = UIScreen.main.bounds.width

func getCellWidth() -> CGFloat {
    let cellWidth = screenWidth - (paddingSpace/CGFloat((numberOfItemsInRow - 1)))
    return cellWidth
}
