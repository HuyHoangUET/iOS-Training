//
//  ViewController.swift
//  TableView
//
//  Created by LTT on 10/22/20.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    let array = [1, 2, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "HomeCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCell
        let item = array[indexPath.row]
        cell.viewLabel.text = String(item)
        return cell
    }
    
    
}

