//
//  CollectionViewCell.swift
//  HitsManager
//
//  Created by LTT on 11/2/20.
//

import Foundation
import UIKit
import RealmSwift

class HitCollectionViewCell: UICollectionViewCell {
    // MARK: - outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    weak var delegate: HitCollectionViewDelegate?
    let loadingIndicator = UIActivityIndicatorView()
    var item = Item()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        likeButton.setImage(nil, for: .normal)
    }
    
    func setImageForCell(image: UIImage, id: Int, url: String, imageWidth: CGFloat, imageHeight: CGFloat, userImageUrl: String, username: String) {
        imageView.image = image
        self.item.id = id
        self.item.imageURL = url
        self.item.imageWidth = imageWidth
        self.item.imageHeight = imageHeight
        self.item.userImageUrl = userImageUrl
        self.item.username = username
    }
    
    func showLoadingIndicator() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.center = imageView.center
        loadingIndicator.style = .medium
        loadingIndicator.color = .white
        imageView.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    // MARK: - action
    @IBAction func likeButton(_ sender: UIButton) {
        let heartImage = UIImage(systemName: "heart.fill")
        if sender.currentImage == heartImage {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            delegate?.didDisLikeImage(id: item.id)
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            delegate?.didLikeImage(id: item.id, url: item.imageURL, imageWidth: item.imageWidth, imageHeight: item.imageHeight, userImageUrl: item.userImageUrl, username: item.username)
            
        }
    }
}
