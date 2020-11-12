//
//  Protocols.swift
//  HitsManager
//
//  Created by LTT on 11/12/20.
//

import Foundation
import UIKit

protocol HitCollectionViewDelegate: class {
    func didTabHeartButton(cell: HitCollectionViewCell, button: UIButton, id: Int)
}
