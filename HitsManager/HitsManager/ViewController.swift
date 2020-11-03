//
//  ViewController.swift
//  HitsManager
//
//  Created by LTT on 11/2/20.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hits = [Hit]()
    let dataManager = DataManager()
    let apiURL = "https://pixabay.com/api/?key=13112092-54e8286568142add194090167&q=girl"
    let numberOfItemsInRow = 3
    let layout = UICollectionViewFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        dataManager.getHits(url: apiURL, completion: {[weak self] hits in
            self?.hits = hits
            self?.collectionView.reloadData()
        })
        let screenWidth = UIScreen.main.bounds.width - 12
        layout.sectionInset = UIEdgeInsets(top: 20, left: 3, bottom: 10, right: 3)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        collectionView!.collectionViewLayout = layout
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let item = hits[indexPath.row]
        dataManager.getImage(url: item.imageURL, completion: { image in
            cell.imageView.image = image
        })
        return cell
    }
}

