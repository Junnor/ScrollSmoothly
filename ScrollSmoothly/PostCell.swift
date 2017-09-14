//
//  PostCell.swift
//  AHDataGenerator
//
//  Created by ju on 2017/9/14.
//  Copyright © 2017年 ju. All rights reserved.
//

import UIKit
import Kingfisher


//let cellBackgroundColor = UIColor(red: 35, green: 34, blue: 38, alpha: 1.0)
//let collectionViewBackgroundColor = UIColor(red: 46, green: 45, blue: 49, alpha: 1.0)
//let textColor = UIColor(red: 128, green: 128, blue: 128, alpha: 1.0)


class PostCell: UICollectionViewCell {

    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var cardCollectionView: UICollectionView! {
        didSet {
            cellCollectionViewManager.collectionView = cardCollectionView
            cardCollectionView.isScrollEnabled = false
            cardCollectionView.dataSource = cellCollectionViewManager
            cardCollectionView.delegate = cellCollectionViewManager
        }
        
    }
    
    @IBOutlet weak var contentLabelConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewConstraintHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avtarImageView.layer.cornerRadius = avtarImageView.bounds.width/2
        avtarImageView.layer.masksToBounds = true
        avtarImageView.layer.borderWidth = 1.0
        avtarImageView.layer.borderColor = UIColor.gray.cgColor
    }
    
    private let cellCollectionViewManager = PostCollectionManager()

    var viewController: UIViewController? {
        didSet {
            cellCollectionViewManager.mainViewController = viewController
        }
    }

    var psotViewModel: PostViewModel? {
        didSet {
            guard let postViewModel = psotViewModel else { return }
            
            configureCellWithPostViewModel(postView: postViewModel)
        }
    }
    
    
    private func configureCellWithPostViewModel(postView: PostViewModel) {
        if let post = postView.post {
            titleLabel.text = post.author
            contentLabel.text = post.contentText
            
            configureCellCollectionView(post: post, postView:postView)
            
            layoutContent(postView: postView)
            
            configureAvatarWith(urlString: post.avatarUrlString)
        }
    }
    
    private func configureAvatarWith(urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
            avtarImageView.kf.setImage(with: resource,
                                       placeholder: nil,
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
        }
    }
    
    private func configureCellCollectionView(post: Post, postView: PostViewModel) {
        if let imagesString = post.imagesString, imagesString.count > 0 {
            cellCollectionViewManager.post = post
            cellCollectionViewManager.collectionView = cardCollectionView
        }
    }
    
    private func layoutContent(postView: PostViewModel) {
        contentLabelConstraintHeight.constant = postView.mainTextHeight
        collectionViewConstraintHeight.constant = postView.pictureCollectionHeight
    }

}
