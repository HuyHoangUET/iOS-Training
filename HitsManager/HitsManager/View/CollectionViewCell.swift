//
//  CollectionViewCell.swift
//  HitsManager
//
//  Created by LTT on 11/2/20.
//

import Foundation
import UIKit

var imageCallBack: ((UIImage) -> ())?

class CollectionViewCell: UICollectionViewCell {
    // MARK: - outlet
    @IBOutlet weak var imageView: UIImageView!
    
    var hits = [Hit]()
    let dataManager = DataManager()
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func selectCell(cellWidth: CGFloat) -> CGSize {
        imageView.contentMode = .scaleAspectFit
        let imageWidth = imageView.image?.size.width ?? CGFloat(0)
        let imageHeight = imageView.image?.size.height ?? CGFloat(0)
        let cellHeight = cellWidth * (imageHeight / imageWidth)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func deSelectCell() {
        imageView.contentMode = .scaleAspectFill
    }
    
    func createCell(image: UIImage) {
        imageView.image = image
    }
}
