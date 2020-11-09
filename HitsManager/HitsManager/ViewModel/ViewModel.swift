//
//  ViewModel.swift
//  HitsManager
//
//  Created by LTT on 11/6/20.
//

import Foundation
import UIKit

class ViewModel {
    let dataManager = DataManager()
    var hits = [Hit]()
    var sellectedCell = IndexPath()
    private let numberOfItemsInRow = 3
    private let paddingSpace = CGFloat(12)
    private let screenWidth = UIScreen.main.bounds.width
    private var itemsWidth = CGFloat()
    var curentPage = 1
    var nextPage = 1
    
    // get hits by page number
    func getHitsInPage(url: String, completion: @escaping ([Hit]) -> ()) {
            dataManager.get(url: url + "&page=\(curentPage)") { (data) in
                do {
                    let result = try JSONDecoder().decode(Result.self, from: data)
                    self.hits += result.hits
                    completion(self.hits)
                } catch {
                    print("get hits failed!")
                }
            }
    }
    
    func sizeForSellectedItem(indexPath: IndexPath, collectionView: UICollectionView) -> CGSize {
        let cellWidth = screenWidth - (paddingSpace/CGFloat((numberOfItemsInRow - 1)))
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        return cell.sizeForSelectedCell(cellWidth: cellWidth)
    }
    
    func getInsertOfSection() -> UIEdgeInsets {
        let insertOfSection = UIEdgeInsets(top: 20, left: paddingSpace/CGFloat(numberOfItemsInRow + 1), bottom: 10, right: paddingSpace/CGFloat(numberOfItemsInRow + 1))
        return insertOfSection
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
    
    func getMinimumInteritemSpacingForSection() -> CGFloat {
        let minimumInteritemSpacingForSection = paddingSpace/CGFloat(numberOfItemsInRow + 1)
        return minimumInteritemSpacingForSection
    }
    
    func getMinimumLineSpacingForSection() -> CGFloat {
        let minimumLineSpacingForSection = paddingSpace/CGFloat(numberOfItemsInRow + 1)
        return minimumLineSpacingForSection
    }
}
