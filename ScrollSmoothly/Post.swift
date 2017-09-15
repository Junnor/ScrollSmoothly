//
//  Post.swift
//  ScrollSmoothly
//
//  Created by ju on 2017/9/14.
//  Copyright © 2017年 ju. All rights reserved.
//

import UIKit


let padding: CGFloat = 8
let cellCollectionViewPadding: CGFloat = 2
let avatarHeight: CGFloat = 50
let commentHeight: CGFloat = 50


class PostViewModel: NSObject {
    
    var cellHeight: CGFloat = 0

    var contentTextHeight: CGFloat = 0.0
    var pictureCollectionHeight: CGFloat = 0.0
    
    var post: Post? {
        didSet {
            if let post = post {            
                
                cellHeight = padding + avatarHeight + commentHeight
                let screenWidth = UIScreen.main.bounds.width
                
                var emptyContentText = true
                
                let leadingSpace: CGFloat = 56 // ( 8 + 40 + 8)
                let trainingSpace: CGFloat = 8
                let gap = leadingSpace + trainingSpace

                if let contentText = post.contentText, contentText.characters.count > 0 {
                    emptyContentText = false
                    let textWidth = screenWidth - gap
                    let font = UIFont(name: "PingFangSC-Regular", size: 16)!  // 字体必须和 storyboard 设置的一致
                    
                    let height = contentText.boundingRect(with: textWidth, font: font, limitLines: 0).height + 10 // 多出 10 的间隙
                    
                    contentTextHeight = height
                    cellHeight += contentTextHeight + padding
                }
                
                if let images = post.imagesString, images.count > 0 {
                    
                    // MARK: - 第一种方法布局
                    /*
                    let pictureMaxWidth: CGFloat = UIScreen.main.bounds.width - (gap + cellCollectionViewPadding * 2)
                    
                    let maxWidth = pictureMaxWidth
                    
                    let width = maxWidth / 3
                    let height = width
                    
                    let extraRow = (images.count % 3 == 0) ? 0 : 1
                    let count = images.count / 3 + extraRow
                    let linePadding = CGFloat(count - 1) * cellCollectionViewPadding
                    
                    pictureCollectionHeight = height * CGFloat(count) + linePadding
                     
                    cellHeight += pictureCollectionHeight + padding
                    let gapBetweenImageAndComment = padding / 2
                    cellHeight += gapBetweenImageAndComment
                    */
                    
                    // MARK: - 第二种方法布局
                    let pictureMaxWidth: CGFloat = UIScreen.main.bounds.width - (gap + cellCollectionViewPadding * 2)
                    
                    let maxWidth = pictureMaxWidth
                    
                    let bigWidth = maxWidth / 2
                    let middleWidth = maxWidth / 3  //  .. normal
                    let smallWidth = maxWidth / 4

                    switch images.count {
                    case 1:
                        pictureCollectionHeight = bigWidth
                    case 2:
                        pictureCollectionHeight = bigWidth
                    case 3, 4, 6, 9:
                        let gap = CGFloat(images.count / 3 - 1) * cellCollectionViewPadding
                        pictureCollectionHeight = CGFloat(images.count) * middleWidth + gap
                    case 5:
                        pictureCollectionHeight = bigWidth + middleWidth + cellCollectionViewPadding
                    case 7:
                        pictureCollectionHeight = middleWidth + smallWidth + cellCollectionViewPadding
                    case 8:
                        pictureCollectionHeight = smallWidth * 2 + cellCollectionViewPadding
                    default:
                        break
                    }
                    
                    cellHeight += pictureCollectionHeight + padding
                    let gapBetweenImageAndComment = padding / 2
                    cellHeight += gapBetweenImageAndComment
                }
                
                if emptyContentText {
                    // 因为 contentText 的 topSpace = 8 bottonSpace = 8，而当 contentText 为空时，会有多了 8 + 8 的空隙
                    cellHeight += padding
                }
                
            }
        }
    }
}

class Post: NSObject {
    
    // data
    var author: String
    var avatarUrlString: String?
    var contentText: String?
    var imagesString: [String]?
    
    init(dict: [String: Any]) {
        self.author = dict["author"] as! String
        
        self.avatarUrlString = dict["avatar"] as? String
        self.contentText = dict["contentText"] as? String
        self.imagesString = dict["pics"] as? [String]
    }

}
