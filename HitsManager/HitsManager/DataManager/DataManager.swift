//
//  DataManager.swift
//  HitsManager
//
//  Created by LTT on 11/2/20.
//

import Foundation
import Alamofire
import AlamofireImage

class DataMnager {
    func getHit(url: String) -> [Hit] {
        var hits = [Hit]()
        guard url != "" else {return []}
        AF.request(url).response {
            response in
            guard let data = response.data else {return}
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                hits = result.hits
            } catch let error as Error {
                print(error.localizedDescription)
            }
        }
        return hits
    }
    func getImage(url: String) -> UIImage {
        var image = UIImage()
        guard url != "" else { return UIImage() }
        AF.request(url).responseImage {
            response in
            guard let data = response.data else {return}
            image = UIImage(data: data, scale: 1) ?? UIImage()
        }
        return image
    }
}
