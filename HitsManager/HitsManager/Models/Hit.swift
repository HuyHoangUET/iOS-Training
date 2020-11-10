//
//  Hit.swift
//  HitsManager
//
//  Created by LTT on 11/2/20.
//

import Foundation

struct Hit: Decodable {
    let id: Int
    let imageURL: String
    let imageWidth: Float
    let imageHeight: Float
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageURL = "largeImageURL"
        case imageWidth = "imageWidth"
        case imageHeight = "imageHeight"
    }
}
