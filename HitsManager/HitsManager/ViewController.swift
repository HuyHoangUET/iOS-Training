//
//  ViewController.swift
//  HitsManager
//abc
//  Created by LTT on 11/2/20.
//

import UIKit


class ViewController: UIViewController {
    // MARK: - outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var mainView: UIView!
    

    private let apiURL = "https://pixabay.com/api/?key=13112092-54e8286568142add194090167&q=girl"
    private let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        // get data from api
        viewModel.getHitsInPage(url: apiURL, completion: {[weak self] hits in
            self?.collectionView.reloadData()
        })
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let hit = viewModel.hits[indexPath.row]
            viewModel.dataManager.getImage(url: hit.imageURL, completion: { image in
            cell.createCell(image: image)
        })
        if indexPath.row >= viewModel.hits.count - 1 {
            viewModel.nextPage += 1
        }
        return cell
    }
}

// Set layout for item
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.getInsertOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewModel.sellectedCell == indexPath {
            return viewModel.sizeForSellectedItem(indexPath: indexPath,
                                  collectionView: collectionView)
        }
        
        return viewModel.getSizeForItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.getMinimumInteritemSpacingForSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.getMinimumLineSpacingForSection()
    }
}

// Custom sellected cell
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.sellectedCell = indexPath
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.sellectedCell = IndexPath()
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.sizeForDeselectedCell()
    }
}

// load more
extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if viewModel.nextPage > viewModel.curentPage {
            viewModel.curentPage += 1
            viewModel.getHitsInPage(url: apiURL) { (hits) in
                collectionView.reloadItems(at: indexPaths)
            }
        }
        print(indexPaths)
        print(viewModel.hits.count)
    }
}
