//
//  ViewController.swift
//  HitsManager
//abc
//  Created by LTT on 11/2/20.
//

import UIKit

let apiURL = "https://pixabay.com/api/?key=13112092-54e8286568142add194090167&q=girl"

class ViewController: UIViewController {
    // MARK: - outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    var hits = [Hit]()
    let dataManager = DataManager()
    let numberOfItemsInRow = 3
    let paddingSpace = CGFloat(12)
    let screenWidth = UIScreen.main.bounds.width
    var sellectedCell = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // get data from api
        dataManager.getHits(url: apiURL, completion: {[weak self] hits in
            self?.hits = hits
            self?.collectionView.reloadData()
        })
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let hit = hits[indexPath.row]
        dataManager.getImage(url: hit.imageURL, completion: { image in
            cell.createCell(image: image)
        })
        return cell
    }
}

// Set layout for item
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: paddingSpace/CGFloat(numberOfItemsInRow + 1), bottom: 10, right: paddingSpace/CGFloat(numberOfItemsInRow + 1))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsWidth = screenWidth - paddingSpace
        if sellectedCell == indexPath {
            let cellWidth = screenWidth - (paddingSpace/CGFloat((numberOfItemsInRow - 1)))
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            return cell.selectCell(cellWidth: cellWidth)
        }
        
        return CGSize(width: itemsWidth/CGFloat(numberOfItemsInRow),
                      height: itemsWidth/CGFloat(numberOfItemsInRow))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return paddingSpace/CGFloat(numberOfItemsInRow + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return paddingSpace/CGFloat(numberOfItemsInRow + 1)
    }
}

// Custom sellected cell
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sellectedCell.append(indexPath)
        sellectedCell = indexPath
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.deSelectCell()
    }
}

