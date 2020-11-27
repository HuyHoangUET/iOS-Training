//
//  TableViewCell.swift
//  HitsManager
//
//  Created by LTT on 20/11/2020.
//

import Foundation
import UIKit

class HitTableViewCell: UITableViewCell {
    
    // MARK: - outlet
    @IBOutlet weak var userInforView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var hitImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var heightOfHitImageView: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hitImageView.image = nil
        userImageView.image = nil
    }
    
    func setBoundsToUserImage() {
        userImageView.layer.cornerRadius = userImageView.frame.height / 2.0
        userImageView.layer.masksToBounds = true
    }
    
    func setHeightOfHitImageView(imageWidth: CGFloat, imageHeight: CGFloat) {
        let ratio = imageHeight / imageWidth
        let widthOfHitImageView = hitImageView.frame.width
        let heightOfHitImageView = widthOfHitImageView * ratio
        self.heightOfHitImageView.constant = heightOfHitImageView
    }    
    func setImageForHitImageView(image: UIImage) {
        hitImageView.image = image
    }
    
    func setImageForUserImageView(image: UIImage) {
        userImageView.image = image
    }
    // MARK: - action
    @IBAction func likeButton(_ sender: Any) {
    }
}
