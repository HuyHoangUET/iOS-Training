//
//  HitCollectionViewController.swift
//  Instagram
//
//  Created by LTT on 22/12/2020.
//

import Foundation
import RxSwift

class HitCollectionViewController: UIViewController {
    // MARK: - outlet
    @IBOutlet weak var hitCollectionView: UICollectionView!
    private let hitViewModel = HitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hitCollectionView.register(UINib.init(nibName: "HitCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        hitViewModel.getHitByPage() { hits in
            DispatchQueue.main.async {
                self.hitCollectionView.reloadData()
            }
        }
    }
}

extension HitCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(hitViewModel.hits)
        return hitViewModel.hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hitCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HitCollectionViewCell
        return cell
    }
    
    
}
extension HitCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return hitViewModel.getInsetOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return hitViewModel.getSizeForItem()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return hitViewModel.getMinimumInteritemSpacingForSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return hitViewModel.getMinimumLineSpacingForSection()
    }
}
