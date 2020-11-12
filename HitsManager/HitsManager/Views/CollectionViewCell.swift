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
    
    let loadingIndicator = UIActivityIndicatorView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func sizeForSelectedCell(cellWidth: CGFloat) -> CGSize {
        imageView.contentMode = .scaleAspectFit
        let imageWidth = imageView.image?.size.width ?? CGFloat(0)
        let imageHeight = imageView.image?.size.height ?? CGFloat(0)
        let cellHeight = cellWidth * (imageHeight / imageWidth)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func sizeForDeselectedCell() {
        imageView.contentMode = .scaleAspectFill
    }
    
    func configureCell(image: UIImage) {
        imageView.image = image
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
    @IBAction func heartButton(_ sender: UIButton) {
        var image = UIImage(systemName: "heart.fill")
        if sender.currentImage == image {
            image = UIImage(systemName: "heart")
        }
        sender.setImage(image, for: .normal)
    }
}
