//
//  ViewModel.swift
//  HitsManager
//
//  Created by LTT on 11/6/20.
//

import Foundation
import UIKit
import RealmSwift

class ViewModel {
    weak var delegate: HitCollectionViewDelegate?
    let dataManager = DataManager()
    var hits: [Hit] = []
    var sellectedCell = IndexPath()
    var curentPage = 1
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    // Get data from api
    func getHitsByPage(completion: @escaping ([Hit]) -> ()) {
        dataManager.get(url: apiURL + "&page=\(curentPage)") {[weak self] (data) in
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                self?.hits += result.hits
                print("\(self?.hits)")
                completion(self?.hits ?? [])
            } catch {
                print("get hits failed!")
            }
        }
    }
    
    func getHitsInNextPage(indexPaths: [IndexPath], completion: @escaping ([Hit]) -> ()) {
        if indexPaths.last?.row == hits.count - 1 {
            curentPage += 1
            getHitsByPage() { (hits) in
                completion(self.hits)
            }
        }
    }
    
    func cacheImage(image: UIImage, idImage: Int) {
        imageCache.setObject(image, forKey: "\(idImage)" as NSString)
    }
    
    func getImageForCell(indexPath: IndexPath, completion: @escaping (UIImage) -> ()) {
        let image = imageCache.object(forKey: "\(hits[indexPath.row].id)" as NSString) as? UIImage
        if image == nil {
            dataManager.getImage(url: hits[indexPath.row].imageURL) { (image) in
                self.imageCache.setObject(image, forKey: "\(self.hits[indexPath.row].id)" as NSString)
                completion(image)
            }
        } else {
            completion(image ?? UIImage())
        }
    }
}
