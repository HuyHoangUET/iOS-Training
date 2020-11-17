//
//  CollectionViewCell.swift
//  HitsManager
//
//  Created by LTT on 11/2/20.
//

import Foundation
import UIKit

class HitCollectionViewCell: UICollectionViewCell {
    // MARK: - outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    weak var delegate: HitCollectionViewDelegate?
    let loadingIndicator = UIActivityIndicatorView()
    var idImage = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        likeButton.setImage(nil, for: .normal)
    }
    
    func sizeForSellectedCell(cellWidth: CGFloat) -> CGSize {
        imageView.contentMode = .scaleAspectFit
        let imageWidth = imageView.image?.size.width ?? 0
        let imageHeight = imageView.image?.size.height ?? 0
        let cellHeight = cellWidth * (imageHeight / imageWidth)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func sizeForDesellectedCell() {
        imageView.contentMode = .scaleAspectFill
    }
    
    func setImageForCell(image: UIImage, id: Int) {
        imageView.image = image
        self.idImage = id
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
        guard let cell = sender.superview?.superview as? HitCollectionViewCell else { return }
        if sender.currentImage == heartImage {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            delegate?.didDisLikeImage(id: cell.idImage)
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            delegate?.didLikeImage(id: cell.idImage)
        }
    }
}
