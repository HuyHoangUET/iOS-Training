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
    
    let hits = [Hit]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.lectionViewCell", bundle: .main)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let item = hits[indexPath.row]
        cell.imageView.image = UIImage()
        return cell
    }
    
    
}

