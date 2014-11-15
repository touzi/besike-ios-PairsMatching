//
//  Utils.swift
//  PairsMatchingGame
//
//  Created by touzi on 14/11/15.
//  Copyright (c) 2014年 touzi. All rights reserved.
//

import Foundation

func shuffle<T>(inout array: [T]) {
    for i in 1 ..< array.count {
        let j = Int(arc4random_uniform(UInt32(i)))
        (array[i], array[j]) = (array[j], array[i])
    }
}

func delay(delay: Double, block:()->()) {
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW,
        Int64(delay * Double(NSEC_PER_SEC))
    ),
        dispatch_get_main_queue(), block)
}