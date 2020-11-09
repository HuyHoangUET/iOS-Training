//
//  DataManager.swift
//  HitsManager
//
//  Created by LTT on 11/2/20.
//

import Foundation
import Alamofire
import AlamofireImage

class DataManager {
    func get(url: String, completion: @escaping (Data) -> Void){
        guard url != "" else { return }
        AF.request(url).response {
            response in
            guard let data = response.data else { return }
            completion(data)
        }
    }
    func getImage(url: String, completion: @escaping (UIImage) ->()) {
        var image = UIImage()
        guard url != "" else { return }
        AF.request(url).responseImage {
            response in
            guard let data = response.data else { return }
            image = UIImage(data: data, scale: 1) ?? UIImage()
            completion(image)
        }
    }
}
