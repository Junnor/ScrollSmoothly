//
//  PostCollectionManager.swift
//  AHDataGenerator
//
//  Created by ju on 2017/9/14.
//  Copyright © 2017年 ju. All rights reserved.
//

import UIKit
import Kingfisher

class PostCollectionManager: NSObject {
    
    weak var mainViewController: UIViewController?  // for present image
    
    weak var collectionView: UICollectionView?
    
    var post: Post? {
        didSet {
            if let post = post, let imagesString = post.imagesString  {
                cardsUrlString  = imagesString
            }
        }
    }
    
    fileprivate var cardsUrlString = [String]() {
        didSet {
            collectionView?.reloadData()
        }
    }
}

extension PostCollectionManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsUrlString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        if let cell = cell as? ImageCell {
            
            let urlString = cardsUrlString[indexPath.item]
            if let url = URL(string: urlString) {
                let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
                cell.imageView.kf.setImage(with: resource,
                                           placeholder: nil,
                                           options: [.transition(.fade(1))],
                                           progressBlock: nil,
                                           completionHandler: nil)
            }

        }
        
        return cell
    }
}

extension PostCollectionManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item = \(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 2 * cellCollectionViewPadding) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellCollectionViewPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellCollectionViewPadding
    }
}


