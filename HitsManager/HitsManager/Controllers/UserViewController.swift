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
    
    private let viewModel = ViewModel()
    private let sizeOfItem = SizeOfItem()
    private var listImageUrl: [String] = []
    private var badgeNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listImageUrl = DidLikeHit.getListUrl()
        imageCollectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        customUserImage()
        customUsernameLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let newListImageUrl = DidLikeHit.getListUrl()
        
        if listImageUrl != newListImageUrl {
            for url in newListImageUrl {
                if !listImageUrl.contains(url) {
                    badgeNumber += 1
                }
            }
            listImageUrl = newListImageUrl
            imageCollectionView.reloadData()
        }
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
        return sizeOfItem.getInsetOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeOfItem.getSizeForItem()
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sizeOfItem.getMinimumInteritemSpacingForSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sizeOfItem.getMinimumLineSpacingForSection()
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
}

// Custom user view
extension UserViewController {
    func customUserImage() {
        userImageView.layer.cornerRadius = userImageView.frame.width / 2.0
        userImageView.layer.masksToBounds = true
    }
    
    func customUsernameLabel() {
        usernameLabel.text = "username"
    }
    
    func customNumberOfImageLabel() {
        numberOfImagesLabel.text = "\(listImageUrl.count) ảnh đã thích"
    }
}
