//
//  ViewController.swift
//  HitsManager
//abc
//  Created by LTT on 11/2/20.
//

import UIKit


class ViewController: UIViewController {
    // MARK: - outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    
    private let viewModel = ViewModel()
    var setDidLikeImagesId = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        viewModel.showCollectionView(collectionView: collectionView)
    }
}

// Set cell for collectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HitCollectionViewCell
        cell?.delegate = self
        let hit = viewModel.hits[indexPath.row]
        viewModel.showHitCollectionViewCell(hit: hit, cell: cell ?? HitCollectionViewCell())
        viewModel.handleLikeButton(setDidLikeImagesId: setDidLikeImagesId, cell: cell ?? HitCollectionViewCell(), indexPath: indexPath)
        return cell ?? HitCollectionViewCell()
    }
}

// Custom cell
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.getInsertOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.sellectedCell == indexPath {
            return viewModel.getSizeForDidSellectItem(collectionView: collectionView, indexPath: indexPath)
        }
        
        return viewModel.getSizeForItem()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.getMinimumInteritemSpacingForSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.getMinimumLineSpacingForSection()
    }
    
    // Sellect cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSellectCell(indexPath: indexPath, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.sellectedCell = IndexPath()
        viewModel.didDeSellectCell(collectionView: collectionView, indexPath: indexPath)
    }
}

// Load more page
extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        viewModel.loadMorePage(collectionView: collectionView, indexPaths: indexPaths)
    }
}

// Handle like image
extension ViewController: HitCollectionViewDelegate {
    func didLikeImage(id: Int) {
        setDidLikeImagesId.insert(id)
    }
    
    func didDisLikeImage(id: Int) {
        setDidLikeImagesId.remove(id)
    }
}
