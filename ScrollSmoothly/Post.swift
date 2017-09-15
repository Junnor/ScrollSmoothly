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
                
                if let contentText = post.contentText, contentText.characters.count > 0 {
                    emptyContentText = false
                    let textWidth = screenWidth - 2 * padding
                    let font = UIFont(name: "PingFangSC-Regular", size: 16)!  // 字体必须和 storyboard 设置的一致
                    
                    let height = contentText.boundingRect(with: textWidth, font: font, limitLines: 6).height + 10 // 多出 10 的间隙
                    
//                    let height = (contentText as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).height + 20  // 20 为头部和底部的间隙
                    
                    contentTextHeight = height
                    cellHeight += contentTextHeight + padding
                }
                
                if let images = post.imagesString, images.count > 0 {
                    
                    let pictureMaxWidth: CGFloat = UIScreen.main.bounds.width - (padding * 2 + cellCollectionViewPadding * 2)
                    
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
