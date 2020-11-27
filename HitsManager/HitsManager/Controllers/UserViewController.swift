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
    
    private let userViewModel = UserViewModel()
    private let sizeOfItem = SizeOfCollectionViewItem()
    private var didLikeHits: [DidLikeHit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        didLikeHits = DidLikeHit.getListDidLikeHit()
        imageCollectionView.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        customUserImage()
        customUsernameLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let newDidLikeHits = DidLikeHit.getListDidLikeHit()
        
        if didLikeHits != newDidLikeHits {
            didLikeHits = newDidLikeHits
            imageCollectionView.reloadData()
        }
        customNumberOfImageLabel()
    }
}

// Create cell
extension UserViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return didLikeHits.count
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

// Select cell
extension UserViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userViewModel.chosenIndexPath = indexPath
        self.performSegue(withIdentifier: "segue", sender: nil)
    }
}

// Display collectionView cell
extension UserViewController {
    func initHitCollectionViewCell(indexPath: IndexPath) -> HitCollectionViewCell {
        guard let cell = self.imageCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HitCollectionViewCell else { return HitCollectionViewCell()}
        cell.showLoadingIndicator()
        cell.likeButton.isHidden = true
        self.userViewModel.dataManager.getImage(url: didLikeHits[indexPath.row].url) { (image) in
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
        numberOfImagesLabel.text = "\(didLikeHits.count) ảnh đã thích"
    }
}

extension UserViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UserTableViewController {
            let tableView = segue.destination as? UserTableViewController
            userViewModel.isDisplayCellAtChosenIndexPath = true
            tableView?.userViewModel = userViewModel
        }
    }
}
