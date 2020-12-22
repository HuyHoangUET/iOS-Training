//
//  HitViewModel.swift
//  Instagram
//
//  Created by LTT on 22/12/2020.
//

import Foundation
import RxSwift

class HitViewModel {
    private let aPIManager = APIManager()
    private var currentPage = 1
    private var nextPage = 2
    var hits: [Hit] = []
    private let numberOfItemsInRow = 3
    private let paddingSpace: CGFloat = 12
    private let screenWidth = UIScreen.main.bounds.width
    
    func getHitByPage(completion: @escaping ([Hit]) -> Void) {
        var hits: [Hit] = []
        let pageUrl = url + "&page=\(currentPage)"
        aPIManager.getHit(url: pageUrl) { hitsInPage in
            hits += hitsInPage
            completion(hits)
        }
    }
    
    func getHitInNextPage(completion: @escaping ([Hit]) -> Void) {
        if nextPage <= currentPage {
            nextPage += 1
        }
        getHitByPage() { hits in
            completion(hits)
        }
    }

    func getCellWidth() -> CGFloat {
        let cellWidth = screenWidth - (paddingSpace/CGFloat(numberOfItemsInRow - 1))
        return cellWidth
    }
    
    func getInsetOfSection() -> UIEdgeInsets {
        let insetOfSection = UIEdgeInsets(top: 3,
                                          left: paddingSpace/CGFloat(numberOfItemsInRow + 1),
                                          bottom: 10, right: paddingSpace/CGFloat(numberOfItemsInRow + 1))
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
    
    func getMinimumInteritemSpacingForSection() -> CGFloat {
        let minimumInteritemSpacingForSection = paddingSpace/CGFloat(numberOfItemsInRow + 1)
        return minimumInteritemSpacingForSection
    }
    
    func getMinimumLineSpacingForSection() -> CGFloat {
        let minimumLineSpacingForSection = paddingSpace/CGFloat(numberOfItemsInRow + 1)
        return minimumLineSpacingForSection
    }
}
