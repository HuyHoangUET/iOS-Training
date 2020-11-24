//
//  UserTableViewController.swift
//  HitsManager
//
//  Created by LTT on 20/11/2020.
//

import Foundation
import UIKit

class UserTableViewController: UIViewController {
    
    // MARK: - outlet
    @IBOutlet weak var hitTableView: UITableView!
    
    private var didLikeHits: [DidLikeHit] = []
    private let userViewModel = UserViewModel()
    var firstIndexPath = IndexPath()
    private var isDisplayCellAtFirstIndexPath = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        didLikeHits = DidLikeHit.getListDidLikeHit()
        
        hitTableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let newDidLikeHits = DidLikeHit.getListDidLikeHit()
        if didLikeHits != newDidLikeHits {
            didLikeHits = newDidLikeHits
            hitTableView.reloadData()
        }
    }
}

// Create cell
extension UserTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didLikeHits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = initHittableViewCell(indexPath: indexPath)
        return cell
    }
    
    // Set height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageWitdh = didLikeHits[indexPath.row].imageWidth
        let imageHeight = didLikeHits[indexPath.row].imageHeight
        let itemWitdh = UIScreen.main.bounds.width
        let heightForRow = Float(itemWitdh) * (imageHeight / imageWitdh) + 100
        return CGFloat(heightForRow)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isDisplayCellAtFirstIndexPath {
            hitTableView.scrollToRow(at: firstIndexPath, at: .top, animated: true)
            isDisplayCellAtFirstIndexPath = false
        }
    }
}

// Display cell
extension UserTableViewController {
    func initHittableViewCell(indexPath: IndexPath) -> HitTableViewCell {
        guard let cell = hitTableView.dequeueReusableCell(withIdentifier: "cell") as? HitTableViewCell else { return HitTableViewCell()}
        guard let hit = didLikeHits[safeIndex: indexPath.row] else {return HitTableViewCell()}
        self.userViewModel.dataManager.getImage(url: didLikeHits[indexPath.row].userImageUrl) { (image) in
            cell.userImageView.image = image
            cell.userImageView.layer.cornerRadius = cell.userImageView.frame.height / 2.0
            cell.userImageView.layer.masksToBounds = true
            cell.usernameLabel.text = self.didLikeHits[indexPath.row].username
        }
        self.userViewModel.dataManager.getImage(url: hit.url) { (image) in
            cell.hitImageView.image = image
        }
        return cell
    }
}
