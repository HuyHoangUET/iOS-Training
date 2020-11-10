//
//  DataManager.swift
//  HitsManager
//
//  Created by LTT on 11/2/20.
//

import Foundation
import Alamofire
import AlamofireImage

let apiURL = "https://pixabay.com/api/?key=13112092-54e8286568142add194090167&q=girl"

class DataManager {
    func get(url: String, completion: @escaping (Data) -> Void){
        guard url != "" else { return }
        AF.request(url).response {
            response in
            if response.data != nil {
                let data = response.data
                completion(data!)
            } else {
                print(response.error as Any)
            }
        }
    }
    func getImage(url: String, completion: @escaping (UIImage) ->()) {
        var image = UIImage()
        guard url != "" else { return }
        AF.request(url).responseImage {
            response in
            if response.data != nil {
                let data = response.data
                image = UIImage(data: data!, scale: 1) ?? UIImage()
                completion(image)
            } else {
                print(response.error as Any)
            }
        }
    }
}
