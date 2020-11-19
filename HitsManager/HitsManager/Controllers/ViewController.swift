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
    private let userView = UserViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.prefetchDataSource = self
        collectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
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
        let cell = initHitCollectionViewCell(indexPath: indexPath)
        return cell
    }
}

// Custom cell
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.getInsetOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.sellectedCell == indexPath {
            return getSizeForDidSellectItem(indexPath: indexPath)
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
        viewModel.getHitsInNextPage(indexPaths: indexPaths) { (hits) in
            collectionView.reloadData()
        }
    }
}

// Handle like image
extension ViewController: HitCollectionViewDelegate {
    func didLikeImage(id: Int, url: String) {
        DidLikeHit.addAnObject(id: id, url: url)
    }
    
    func didDisLikeImage(id: Int) {
        DidLikeHit.deleteAnObject(id: id)
    }
    
    func handleLikeButton(cell: HitCollectionViewCell, indexPath: IndexPath) {
        guard let hitId = viewModel.hits[safeIndex: indexPath.row]?.id else { return }
        let listDidLikeImageId = DidLikeHit.getListId()
        if listDidLikeImageId.isSuperset(of: [hitId]) {
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}

// Display collectionView cell
extension ViewController {
    func initHitCollectionViewCell(indexPath: IndexPath) -> HitCollectionViewCell {
        guard let hit = viewModel.hits[safeIndex: indexPath.row] else { return HitCollectionViewCell()}
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HitCollectionViewCell else { return HitCollectionViewCell()}
        cell.delegate = self
        cell.showLoadingIndicator()
        viewModel.dataManager.getImage(url: hit.imageURL) { (image) in
            cell.setImageForCell(image: image, id: hit.id, url: hit.imageURL)
            cell.loadingIndicator.stopAnimating()
            self.handleLikeButton(cell: cell , indexPath: indexPath)
        }
        return cell
    }
    
    func getSizeForDidSellectItem(indexPath: IndexPath) -> CGSize {
        let cellWidth = viewModel.getCellWidth()
        guard let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell else { return CGSize()}
        return cell.sizeForSellectedCell(cellWidth: cellWidth)
    }
    
    func didSellectCell(indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell else { return }
        guard cell.imageView.image != nil else { return }
        if viewModel.sellectedCell != indexPath {
            viewModel.sellectedCell = indexPath
        } else {
            viewModel.sellectedCell = IndexPath()
            cell.sizeForDesellectedCell()
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func didDeSellectCell(indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell else { return }
        cell.sizeForDesellectedCell()
    }
}

// Safe array
extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userView = segue.destination as? UserViewController {
            userView.viewDidLoad()
        }
    }
}
