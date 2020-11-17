//
//  ViewModel.swift
//  HitsManager
//
//  Created by LTT on 11/6/20.
//

import Foundation
import UIKit

class ViewModel {
    weak var delegate: HitCollectionViewDelegate?
    let dataManager = DataManager()
    private let numberOfItemsInRow = 3
    private let paddingSpace = CGFloat(12)
    private let screenWidth = UIScreen.main.bounds.width
    private var itemsWidth = CGFloat()
    var hits: [Hit] = []
    var sellectedCell = IndexPath()
    var curentPage = 1
    var setDidLikeImagesId = Set<Int>()
    
    // Get hits from api
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
    
    func loadMorePage(collectionView: UICollectionView, indexPaths: [IndexPath]) {
        if indexPaths.last?.row == hits.count - 1 {
            curentPage += 1
            getHitsByPage() { (hits) in
                collectionView.reloadItems(at: indexPaths)
            }
        }
    }
    
    // Set size and layout for collection view
    func getSizeForDidSellectItem(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        let cellWidth = screenWidth - (paddingSpace/CGFloat((numberOfItemsInRow - 1)))
        let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell
        return cell?.sizeForSelectedCell(cellWidth: cellWidth) ?? CGSize()
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
