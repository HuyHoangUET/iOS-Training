//
//  Protocols.swift
//  HitsManager
//
//  Created by LTT on 11/12/20.
//

import Foundation
import UIKit

protocol HitCollectionViewDelegate: class {
    func didLikeImage(id: Int, url: String, imageWidth: CGFloat, imageHeight: CGFloat, userImageUrl: String, username: String)
    func didDisLikeImage(id: Int)
}
