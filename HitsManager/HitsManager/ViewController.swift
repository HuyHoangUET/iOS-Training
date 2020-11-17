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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        viewModel.getHitsByPage() { (hits) in
            self.collectionView.reloadData()
        }
    }
}

// Create cell
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HitCollectionViewCell
        cell?.delegate = self
        let hit = viewModel.hits[indexPath.row]
        showHitCollectionViewCell(hit: hit, cell: cell ?? HitCollectionViewCell(), indexPath: indexPath)
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
        didSellectCell(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.sellectedCell = IndexPath()
        didDeSellectCell(indexPath: indexPath)
    }
}

// Load next page
extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        viewModel.getHitsInNextPage(collectionView: collectionView, indexPaths: indexPaths)
    }
}

// Handle like image
extension ViewController: HitCollectionViewDelegate {
    func didLikeImage(id: Int) {
        viewModel.setDidLikeImagesId.insert(id)
    }
    
    func didDisLikeImage(id: Int) {
        viewModel.setDidLikeImagesId.remove(id)
    }
    
    func handleLikeButton(cell: HitCollectionViewCell, indexPath: IndexPath) {
        if viewModel.setDidLikeImagesId.isSuperset(of: [viewModel.hits[indexPath.row].id]) {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}

// Display collectionView cell
extension ViewController {
    func showHitCollectionViewCell(hit: Hit, cell: HitCollectionViewCell, indexPath: IndexPath) {
        cell.showLoadingIndicator()
        viewModel.dataManager.getImage(url: hit.imageURL) { (image) in
            cell.setImageForCell(image: image, id: hit.id)
            cell.loadingIndicator.stopAnimating()
            self.handleLikeButton(cell: cell, indexPath: indexPath)
        }
    }
    
    func didSellectCell(indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell
        if viewModel.sellectedCell != indexPath {
            viewModel.sellectedCell = indexPath
        } else {
            viewModel.sellectedCell = IndexPath()
            cell?.sizeForDeselectedCell()
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func didDeSellectCell(indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell
        cell?.sizeForDeselectedCell()
    }
}
