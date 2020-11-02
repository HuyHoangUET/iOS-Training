//
//  Hit.swift
//  SimpleNetworking
//
//  Created by LTT on 11/2/20.
//

import Foundation

struct Hit: Decodable {
    let id: Int
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageUrl = "largeImageURL"
    }
}
