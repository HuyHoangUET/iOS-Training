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
    var userViewModel: UserViewModel? = nil
    
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
        let itemWitdh = Float(UIScreen.main.bounds.width)
        let heightForRow = itemWitdh * (didLikeHits[indexPath.row].imageHeight / didLikeHits[indexPath.row].imageWidth) + (itemWitdh / 4)
        return CGFloat(heightForRow)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard userViewModel != nil else { return }
        if (userViewModel!.isDisplayCellAtChosenIndexPath) {
            hitTableView.scrollToRow(at: userViewModel?.chosenIndexPath ?? IndexPath(), at: .top, animated: true)
            userViewModel!.isDisplayCellAtChosenIndexPath = false
        }
    }
}

// Display cell
extension UserTableViewController {
    func initHittableViewCell(indexPath: IndexPath) -> HitTableViewCell {
        guard userViewModel != nil else {
            return HitTableViewCell()
        }
        guard let cell = hitTableView.dequeueReusableCell(withIdentifier: "cell") as? HitTableViewCell else { return HitTableViewCell()}
        guard let hit = didLikeHits[safeIndex: indexPath.row] else {return HitTableViewCell()}
        self.userViewModel?.dataManager.getImage(url: didLikeHits[indexPath.row].userImageUrl) { (image) in
            cell.userImageView.image = image
            cell.setBoundsToUserImage()
            cell.usernameLabel.text = self.didLikeHits[indexPath.row].username
        }
        self.userViewModel?.dataManager.getImage(url: hit.url) { (image) in
            cell.hitImageView.image = image
        }
        return cell
    }
}
