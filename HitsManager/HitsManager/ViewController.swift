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
    var likedImagesId = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        viewModel.showCollectionView(collectionView: collectionView)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HitCollectionViewCell
        let hit = viewModel.hits[indexPath.row]
        viewModel.indexPath = indexPath
        cell?.showLoadingIndicator()
        viewModel.setImageCell(hit: hit, cell: cell ?? HitCollectionViewCell())
        cell?.heartButton.addTarget(self, action: #selector(tapHeartButton(sender:)), for: .touchUpInside)
        cell?.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        if likedImagesId.isSuperset(of: [hit.id]) {
            cell?.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
//        cell?.configureCell(indexPath: indexPath, hit: hit)
        return cell ?? HitCollectionViewCell()
    }
}

// Set layout for item
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
            viewModel.indexPath = indexPath
            return viewModel.sizeForSellectedItem(collectionView: collectionView)
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
}

// Custom sellected cell
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell
        cell?.didSellectCell(indexPath: indexPath, collectionView: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.sellectedCell = IndexPath()
        let cell = collectionView.cellForItem(at: indexPath) as? HitCollectionViewCell
        cell?.sizeForDeselectedCell()
    }
}

// load more
extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.last?.row == viewModel.hits.count - 1 {
            viewModel.curentPage += 1
            viewModel.getHitsByPage() { (hits) in
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController {
    @objc func tapHeartButton(sender: UIButton){
        let heartImage = UIImage(systemName: "heart.fill")
        let cell = sender.superview?.superview as! HitCollectionViewCell
        if sender.currentImage == heartImage {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            likedImagesId.remove(cell.idImage)
            
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likedImagesId.insert(cell.idImage)
        }
    }
}
