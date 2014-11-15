//
//  GameLayout.swift
//  PairsMatchingGame
//
//  Created by touzi on 14/11/15.
//  Copyright (c) 2014年 touzi. All rights reserved.
//

import UIKit

class GameLayout {
    
    
    let rows = 5
    let cols = 4
    
    let size = CGSize(width: 65, height: 80)
    
    
    lazy var grid: [CGRect] = {
    
        var rects = [CGRect]()
    
        for row in 0 ..< self.rows {
            for col in 0 ..< self.cols {
                let x = 15 + Int(self.size.width) * col + 10 * col
                let y = 70 + Int(self.size.height) * row + 10 * row
                rects.append(CGRect(origin: CGPoint(x: x, y: y), size: self.size))
            }
        }
        //println("Should generate a \(self.cols)x\(self.rows) grid.")
        //assert(rects.count == self.rows * self.cols,"Should generate a \(self.cols)x\(self.rows) grid.")
    
        return rects
    }()
    
    private let gameLayouts: [[Int]] = [
        [0,0,0,0,
            0,0,0,0,
            0,1,1,0,
            0,0,0,0,
            0,0,0,0],
        
        [0,0,0,0,
            0,0,0,0,
            1,1,1,1,
            0,0,0,0,
            0,0,0,0],
        
        [0,0,0,0,
            0,1,1,0,
            0,1,1,0,
            0,1,1,0,
            0,0,0,0],
        
        [0,0,0,0,
            1,0,0,1,
            1,1,1,1,
            1,0,0,1,
            0,0,0,0],
        
        [1,0,0,1,
            0,1,1,0,
            1,0,0,1,
            0,1,1,0,
            1,0,0,1],
        
        [0,1,1,0,
            1,0,0,1,
            1,1,1,1,
            1,0,0,1,
            0,1,1,0],
        
        [1,1,1,1,
            1,0,0,1,
            1,0,0,1,
            1,0,0,1,
            1,1,1,1],
        
        [1,1,1,1,
            1,0,0,1,
            1,1,1,1,
            1,0,0,1,
            1,1,1,1],
        
        [1,1,1,1,
            1,1,1,1,
            1,0,0,1,
            1,1,1,1,
            1,1,1,1],
        
        [1,1,1,1,
            1,1,1,1,
            1,1,1,1,
            1,1,1,1,
            1,1,1,1],
    ]
}


extension GameLayout {
    
    func forPairs(pairs: Int) -> [CGRect] {
        assert(pairs >= 1 && pairs <= 10)
        
        var rects = [CGRect]()
        let layout = gameLayouts[pairs - 1]
        
//        for row in 0 ..< self.rows {
//            for col in 0 ..< self.cols {
//                if(layout[row * 4 + col] == 1) {
//                    let x = 15 + Int(self.size.width) * col + 10 * col
//                    let y = 70 + Int(self.size.height) * row + 10 * row
//                    rects.append(CGRect(origin: CGPoint(x: x, y: y), size: self.size))
//                }
//            }
//        }
        for(i, rect) in enumerate(self.grid) {
            if layout[i] == 1 {
                rects.append(rect)
            }
        }
        
        println("xxs=> \(rects)")
        return rects
    }
}
