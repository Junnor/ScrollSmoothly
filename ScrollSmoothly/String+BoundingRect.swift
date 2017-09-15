//
//  String+BoundingRect.swift
//  ScrollSmoothly
//
//  Created by ju on 2017/9/15.
//  Copyright © 2017年 ju. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func boundingRect(with width: CGFloat, font: UIFont, limitLines: Int = 0) -> CGRect {
        let size = CGSize(width: width, height: CGFloat(Double.greatestFiniteMagnitude))
        return boundingRect(with: size,
                            options: .usesLineFragmentOrigin,
                            attributes: [NSFontAttributeName: font],
                            context: nil,
                            font: font,
                            limitLines: limitLines)
    }
    
    func boundingRect(with size: CGSize, options: NSStringDrawingOptions = [], attributes: [String : Any]? = nil, context: NSStringDrawingContext?, font: UIFont, limitLines: Int = 0) -> CGRect {
        
        var rect = (self as NSString).boundingRect(with: size,
                                                   options: options,
                                                   attributes: attributes,
                                                   context: context)
        
        let charSize = lroundf(Float(font.lineHeight))
        let rHeight = lroundf(Float(rect.height))
        let lineCount = rHeight / charSize
        
        let limitLines = limitLines < 0 ? 0 :  limitLines
        if lineCount <= limitLines || limitLines == 0 {
            return rect
        } else {
            rect.size.height = rect.height * CGFloat(limitLines) / CGFloat(lineCount)
            return rect
        }
        
    }
}

