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
    @IBOutlet weak var heartButton: UIButton!
    
    weak var delegate: HitCollectionViewDelegate?
    let viewModel = ViewModel()
    let loadingIndicator = UIActivityIndicatorView()
    let dataManager = DataManager()
    var idImage = 0
    var likedImagesId = Set<Int>()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func didSellectCell(indexPath: IndexPath, collectionView: UICollectionView) {
        if viewModel.sellectedCell != indexPath {
            viewModel.sellectedCell = indexPath
        } else {
            viewModel.sellectedCell = IndexPath()
            sizeForDeselectedCell()
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    func didDeSellectCell() {
        sizeForDeselectedCell()
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
    
    func setImageForCell(image: UIImage, id: Int) {
        imageView.image = image
        self.idImage = id
    }
    
    func configureCell(indexPath: IndexPath, hit: Hit) {
        viewModel.indexPath = indexPath
        showLoadingIndicator()
        viewModel.setImageCell(hit: hit, cell: self)
        heartButton.addTarget(self, action: #selector(tapHeartButton(sender:)), for: .touchUpInside)
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        if likedImagesId.isSuperset(of: [hit.id]) {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
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
        let heartImage = UIImage(systemName: "heart.fill")
        if sender.currentImage == heartImage {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        delegate?.didTabHeartButton(cell: self, button: sender, id: idImage)
    }
}

extension HitCollectionViewCell {
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
