//
//  DataGenerator.swift
//  ScrollSmoothly
//
//  Created by ju on 2017/9/14.
//  Copyright © 2017年 ju. All rights reserved.
//

import UIKit

class DataGenerator: NSObject {
    
    // Like singleton instance
    static let generator =  DataGenerator()
    private override init() {}
    
    let randomPicURL = "http://lorempixel.com/400/200"
    let randomPicHolder = "http://placehold.it/350x150"
    let anotherPlaceHolder = "https://placeimg.com/640/480/any"
    
    let paragraph = "一直以来，我们都心存一个设想，期待着能够打造出这样一部 iPhone：它有整面的屏幕，能让你在使用时完全沉浸其中，仿佛忘记了它的存在。"
}

extension DataGenerator {
    
    func randomData() -> [PostViewModel] {
        var postViews = [PostViewModel]()
        let posts = randomPost()
        for post in posts {
            let viewModel = PostViewModel()
            viewModel.post = post
            postViews.append(viewModel)
        }
        
        return postViews
    }
    
    private func randomPost() -> [Post] {
        var posts = [Post]()
        for _ in 0...99 {
            let dict = randomCard()
            let post = Post(dict: dict)
            posts.append(post)
        }
        return posts
    }
    
    private func randomCard() -> [String: Any]{
        var dict = [String: Any]()
        
        let userDict = randomUserProfile()
        dict = userDict
        
        // 85% chance for having a main text
        if randomPercentChance(percent: 80) {
            let smalText = random(0, 2)
            let bigText = random(2, 4)
            // it has 60% chance to have smal text
            let numOfParagraphs = randomPercentChance(percent: 60) ? smalText : bigText
            var contentText: String = ""
            for _ in 0..<numOfParagraphs {
                contentText.append(paragraph)
            }
            dict["contentText"] = contentText
        }
        
        let numOfPics = random(1, 10)
        var pics = [String]()
        for _ in 0..<numOfPics {
            let width = 100 * random(1, 6)
            let height = 100 * random(1, 7)
            let imageUrlA = "http://lorempixel.com/\(width)/\(height)"
            let imageUrlC = "https://placeimg.com/\(width)/\(height)/any"
            let images = [imageUrlA,imageUrlC]
            let imageUrl = images[random(images.count)]
            pics.append(imageUrl)
        }
        dict["pics"] = pics
        
        
        return dict
        
    }
    
    private func randomUserProfile() -> [String : Any] {
        var dict = [String : Any]()
        let name = randomName(with: "乌托邦的 Ju")
        dict["author"] = name
        
        let width = 100 * random(1, 6)
        let height = 100 * random(1, 7)
        let imageUrlC = "https://placeimg.com/\(width)/\(height)/any"
        dict["avatar"] = imageUrlC
        return dict
    }
}

//MARK:- For random helper
extension DataGenerator {
    
    fileprivate func randomName(with prefix: String) -> String {
        let num = random(999)
        return "\(prefix) \(num) "
    }
    
    fileprivate func randomPercentChance(percent: Int) -> Bool {
        let randomNum = random(100)
        if randomNum < percent {
            return true
        }else{
            return false
        }
    }
    
    fileprivate func randomBool() -> Bool {
        let rand = arc4random_uniform(100)
        return rand % 2 == 0 ? true : false
    }
    
    fileprivate func random(_ ceil: Int) -> Int {
        return Int(arc4random_uniform(UInt32(ceil)))
    }
    
    fileprivate func random(_ floor: Int, _ ceil: Int) -> Int {
        guard floor < ceil else {
            return -1
        }
        return Int(arc4random_uniform(UInt32(ceil - floor))) + floor
    }
}



