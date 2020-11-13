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
    private let dataManager = DataManager()
    private let numberOfItemsInRow = 3
    private let paddingSpace = CGFloat(12)
    private let screenWidth = UIScreen.main.bounds.width
    private var itemsWidth = CGFloat()
    var hits = [Hit]()
    var sellectedCell = IndexPath()
    var curentPage = 1
    
    // Handle view
    func showCollectionView(collectionView: UICollectionView) {
        getHitsByPage() { (hits) in
            collectionView.reloadData()
        }
    }
    
    func showHitCollectionViewCell(hit: Hit, cell: HitCollectionViewCell) {
        cell.showLoadingIndicator()
        dataManager.getImage(url: hit.imageURL) { (image) in
            cell.setImageForCell(image: image, id: hit.id)
            cell.loadingIndicator.stopAnimating()
        }
    }
    
    func setImageCell(hit: Hit, cell: HitCollectionViewCell){
        dataManager.getImage(url: hit.imageURL) { (image) in
            cell.setImageForCell(image: image, id: hit.id)
            cell.loadingIndicator.stopAnimating()
        }
    }
    
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
    
    // Handle action when sellect or dissellect an image
    func didSellectCell(indexPath: IndexPath, collectionView: UICollectionView) {
        let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell
        if sellectedCell != indexPath {
            sellectedCell = indexPath
        } else {
            sellectedCell = IndexPath()
            cell?.sizeForDeselectedCell()
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func didDeSellectCell(collectionView: UICollectionView, indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell
        cell?.sizeForDeselectedCell()
    }
    
    // Check like button of image
    func handleLikeButton(setDidLikeImagesId: Set<Int>, cell: HitCollectionViewCell, indexPath: IndexPath) {
        if setDidLikeImagesId.isSuperset(of: [hits[indexPath.row].id]) {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
