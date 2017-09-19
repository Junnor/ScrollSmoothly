//
//  FPSDisplay.swift
//  Scroll
//
//  Created by nyato on 2017/9/19.
//  Copyright © 2017年 moelove. All rights reserved.
//

import UIKit

class FPSDisplay: NSObject {
    
    static let share = FPSDisplay()
    private override init() {
        super.init()
        
        initDisplayLabel()
    }
    
    private var displayLabel: UILabel!
    
    private var link: CADisplayLink!
    private var count = 0
    private var lastTime: TimeInterval = 0
    private var font: UIFont!
    private var subFont: UIFont!
    
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    private func initDisplayLabel() {
        let frame = CGRect(x: width - 100, y: height - 50, width: 80, height: 30)

        displayLabel = UILabel(frame: frame)

        displayLabel.layer.cornerRadius = 5
        displayLabel.clipsToBounds = true
        displayLabel.textAlignment = .center
        displayLabel.isUserInteractionEnabled = false
        displayLabel.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        font = UIFont(name: "Menlo", size: 14)
        if font != nil {
            subFont = UIFont(name: "Menlo", size: 4)
        } else {
            font = UIFont(name: "Courier", size: 14)
            subFont = UIFont(name: "Courier", size: 4)
        }
        
        initCADisplayLink()
        
        UIApplication.shared.keyWindow?.addSubview(displayLabel)        
    }
    
    private func initCADisplayLink() {
        link = CADisplayLink(target: self, selector: #selector(tick(link:)))
        link.add(to: .main, forMode: .commonModes)
    }
    
    
    @objc private func tick(link: CADisplayLink) {
        
        if lastTime == 0 {  // //对LastTime进行初始化
            lastTime = link.timestamp
            return
        }
        
        count += 1 // //记录tick在1秒内执行的次数
        let delta = link.timestamp - lastTime
        
        if delta >= 1 {
            lastTime = link.timestamp
            let fps = Double(count) / delta
            count = 0
            updateDisplayLabelText(for: fps)
        }
    }
    
    private func updateDisplayLabelText(for fps: Double) {
        let  progress = fps / 60.0
        let color = UIColor(hue: CGFloat(0.27 * (progress - 0.2)), saturation: 1, brightness: 0.9, alpha: 1)
        displayLabel.text = "\(round(fps)) FPS"
        displayLabel.textColor = color
    }
    
}
