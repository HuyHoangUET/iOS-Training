//
//  Hit.swift
//  HitsManager
//
//  Created by LTT on 11/2/20.
//

import Foundation
import UIKit

struct Hit: Decodable {
    let id: Int
    let imageURL: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageURL = "largeImageURL"
        case imageWidth = "imageWidth"
        case imageHeight = "imageHeight"
    }
}
