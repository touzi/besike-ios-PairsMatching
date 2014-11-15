//
//  CardView.swift
//  PairsMatchingGame
//
//  Created by touzi on 14/11/15.
//  Copyright (c) 2014年 touzi. All rights reserved.
//

import UIKit

class CardView: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    var card: Card? {
        didSet {
            if card != oldValue {
                frontLayer.contents = UIImage(named: card!.imageName())!.CGImage
            }
        }
    }
    
    var frontLayer: CALayer!
    var backLayer: CALayer!
    
    override var selected: Bool {
        didSet {
            frontLayer.hidden = !selected
            backLayer.hidden = selected
        }
    }
    
    private func setup() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(white: 0.8, alpha: 1).CGColor
        
        self.frontLayer = CALayer()
        self.frontLayer.contents = UIImage(named: "ace_of_hearts")!.CGImage
        self.frontLayer.hidden = true
        self.layer.addSublayer(self.frontLayer)
        
        self.backLayer = CALayer()
        self.backLayer.contents = UIImage(named: "back")!.CGImage
        self.layer.addSublayer(self.backLayer)
    }

    override func layoutSubviews() {
        self.frontLayer.frame = CGRectInset(self.layer.bounds, 2, 2)
        self.backLayer.frame = self.layer.bounds
    }
    
}
