//
//  Result.swift
//  SimpleNetworking
//
//  Created by LTT on 11/2/20.
//

import Foundation

struct Result: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [Hit]
    
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalHits = "totalHits"
        case hits = "hits"
    }
}
