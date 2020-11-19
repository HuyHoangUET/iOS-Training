//
//  UserViewController.swift
//  HitsManager
//
//  Created by LTT on 18/11/2020.
//

import Foundation
import UIKit

class UserViewController: UIViewController{
    
    // MARK: - outlet
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var numberOfImagesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    let viewModel = ViewModel()
    var listImageUrl: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listImageUrl = DidLikeHit.getListUrl()
        imageCollectionView.reloadData()
        imageCollectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        customUserImage()
        customUsernameLabel()
        customNumberOfImageLabel()
    }
}

// Create cell
extension UserViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImageUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = initHitCollectionViewCell(indexPath: indexPath)
        return cell
    }
}

// Custom cell
extension UserViewController: UICollectionViewDelegateFlowLayout {
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
        } else {
            return viewModel.getSizeForItem()
        }
        
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
//        didSellectCell(indexPath: indexPath)
        guard let cell = imageCollectionView.cellForItem(at: indexPath) as? HitCollectionViewCell else { return }
        guard cell.imageView.image != nil else { return }
        if viewModel.sellectedCell != indexPath {
            viewModel.sellectedCell = indexPath
        } else {
            viewModel.sellectedCell = IndexPath()
            cell.sizeForDesellectedCell()
        }
        imageCollectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.sellectedCell = IndexPath()
//        didDeSellectCell(indexPath: indexPath)
        guard let cell = imageCollectionView.cellForItem(at: indexPath) as? HitCollectionViewCell else { return }
        cell.sizeForDesellectedCell()
    }
}

// Display collectionView cell
extension UserViewController {
    func initHitCollectionViewCell(indexPath: IndexPath) -> HitCollectionViewCell {
        guard let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HitCollectionViewCell else { return HitCollectionViewCell()}
        cell.showLoadingIndicator()
        cell.likeButton.isHidden = true
        self.viewModel.dataManager.getImage(url: listImageUrl[indexPath.row]) { (image) in
            cell.imageView.image = image
            cell.loadingIndicator.stopAnimating()
        }
        return cell
    }
    
    func getSizeForDidSellectItem(indexPath: IndexPath) -> CGSize {
        let cellWidth = viewModel.getCellWidth()
        guard let cell = imageCollectionView.cellForItem(at: indexPath) as? HitCollectionViewCell else { return CGSize()}
        return cell.sizeForSellectedCell(cellWidth: cellWidth)
    }
    
    func didSellectCell(indexPath: IndexPath) {
        guard let cell = imageCollectionView.cellForItem(at: indexPath) as? HitCollectionViewCell else { return }
        guard cell.imageView.image != nil else { return }
        if viewModel.sellectedCell != indexPath {
            viewModel.sellectedCell = indexPath
        } else {
            viewModel.sellectedCell = IndexPath()
            cell.sizeForDesellectedCell()
        }
        imageCollectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func didDeSellectCell(indexPath: IndexPath) {
        guard let cell = imageCollectionView.cellForItem(at: indexPath) as? HitCollectionViewCell else { return }
        cell.sizeForDesellectedCell()
    }
}

// Custom user view
extension UserViewController {
    func customUserImage() {
        userImageView.layer.cornerRadius = userImageView.frame.width / 2.0
        userImageView.layer.masksToBounds = true
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor, multiplier: 1).isActive = true
    }
    
    func customUsernameLabel() {
        usernameLabel.text = "username"
    }
    
    func customNumberOfImageLabel() {
        numberOfImagesLabel.text = "\(listImageUrl.count) ảnh đã thích"
    }
}
