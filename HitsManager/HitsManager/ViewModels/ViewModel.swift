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
    private let realm = try! Realm()
    private var badgeNumber = 0
    
    // Get data from api
    func getHitsByPage(completion: @escaping ([Hit]) -> ()) {
        dataManager.get(url: apiURL + "&page=\(curentPage)") {[weak self] (data) in
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                self?.hits += result.hits
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
    
    // Size and layout for collection view
    
    func getInsetOfSection() -> UIEdgeInsets {
        let insetOfSection = UIEdgeInsets(top: 3, left: paddingSpace/CGFloat(numberOfItemsInRow + 1), bottom: 10, right: paddingSpace/CGFloat(numberOfItemsInRow + 1))
        return insetOfSection
    }
    
    func getItemsWidth() -> CGFloat {
        let itemsWidth = screenWidth - paddingSpace
        return itemsWidth
    }
    
    func getSizeForItem() -> CGSize {
        let itemsWidth = getItemsWidth()
        let sizeForItem = CGSize(width: itemsWidth/CGFloat(numberOfItemsInRow),
                             height: itemsWidth/CGFloat(numberOfItemsInRow))
        return sizeForItem
    }
    
    func getSizeForDidSellectItem(imageWidth: CGFloat, imageHeight: CGFloat) -> CGSize {
        let cellWidth = getCellWidth()
        let cellHeight = cellWidth * (imageHeight / imageWidth)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func getMinimumInteritemSpacingForSection() -> CGFloat {
        let minimumInteritemSpacingForSection = paddingSpace/CGFloat(numberOfItemsInRow + 1)
        return minimumInteritemSpacingForSection
    }
    
    func getMinimumLineSpacingForSection() -> CGFloat {
        let minimumLineSpacingForSection = paddingSpace/CGFloat(numberOfItemsInRow + 1)
        return minimumLineSpacingForSection
    }
}
