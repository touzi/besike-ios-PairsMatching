//
//  ViewController.swift
//  PairsMatchingGame
//
//  Created by touzi on 14/11/15.
//  Copyright (c) 2014年 touzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var stepper: UIStepper!
    weak var revealButton: UIButton!
    weak var shuffleButton: UIButton!
    
    var pairsCount: Int {
        return Int(self.stepper.value)
    }
    
    var cardsCount: Int {
        get{
            return self.pairsCount * 2
        }
    }
    
    var gameLayout = GameLayout()
    var cardViews = [CardView]()
    var lastSelectedCardView: CardView?
    
    var matchedPairs: Int = 0 {
        didSet {
            if matchedPairs == pairsCount {
                showDialog()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupControls()
        
        setupCards()
        
        assignCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCards() {
        var toRemove = self.cardViews.count - self.cardsCount
        
        while toRemove > 0 {
            self.cardViews.removeLast().removeFromSuperview()
            toRemove--
        }
        
        var toAdd = self.cardsCount - self.cardViews.count
        
        while toAdd > 0 {
            let cardview = CardView(frame: gameLayout.grid[self.cardViews.count])
            println("cardview => \(cardview)")
            cardview.addTarget(self, action: "tappedCard:", forControlEvents: UIControlEvents.TouchUpInside)
            self.cardViews.append(cardview)
            self.view.addSubview(cardview)
            toAdd--
        }
    }
    
    func tappedCard(cardview: CardView) {
        if cardview.selected {return}
        cardview.selected = true
        if let view = lastSelectedCardView {
            if view.card! == cardview.card! {
                matchedPairs++
            }else {
                delay(0.3, {self.hideCardView(view); self.hideCardView(cardview)})
            }
            lastSelectedCardView = nil
        }else {
            lastSelectedCardView = cardview
        }
    }
    
    func hideCardView(cardview: CardView) {
        cardview.selected = false
    }
    
    func hideCards() {
        self.foreach {
            self.hideCardView($0)
        }
    }
    
    func foreach(block: (CardView) -> ()) {
        for cardview in self.cardViews {
            block(cardview)
        }
    }
    
    func setupControls() {
        //游戏控制器,就是创建两个按钮一个加减器。用代码创建不在Main.storyboard中拖拽
        
        //一个加减器位置
        let stepperFrame = CGRect(x: 113, y: 20, width: 94, height: 30)
        
        //一个翻拍按钮位置
        let revealButtonFrame = CGRect(x: 16, y: 20, width: 48, height: 30)
        
        //一个洗牌按钮位置
        let shuffleButtonFrame = CGRect(x: 256, y: 20, width: 48, height: 30)
        
        
        //TODO: 把创建的空间添加到代码中
        let revealButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        revealButton.frame = revealButtonFrame
        revealButton.setTitle("Reveal", forState: UIControlState.Normal)
        //为按钮添加点击事件
        revealButton.addTarget(self, action: "revealAll:", forControlEvents: UIControlEvents.TouchUpInside)
        self.revealButton = revealButton
        
        let shuffleButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        shuffleButton.frame = shuffleButtonFrame
        shuffleButton.setTitle("Shuffle", forState: UIControlState.Normal)
        shuffleButton.addTarget(self, action: "shuffleCards:", forControlEvents: UIControlEvents.TouchUpInside)
        self.shuffleButton = shuffleButton
        
        //TODO: 配置加减器的beween为1到10（默认值为4）
        //增减量为1
        let stepper = UIStepper(frame: stepperFrame)
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = 4
        stepper.stepValue = 1
        stepper.addTarget(self, action: "stepperValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.stepper = stepper
        
        
        self.view.addSubview(revealButton)
        self.view.addSubview(shuffleButton)
        self.view.addSubview(stepper)
        
    }
    
    
    func revealAll(button: UIButton) {
        revealAllCards()
    }
    
    func revealAll() {
        revealAllCards()
    }
    
    func revealAllCards() {
        self.foreach {
            $0.selected = true
        }
    }
    
    func shuffleCards(button: UIButton) {
        shuffleCards()
    }
    
    func shuffleCards() {
        matchedPairs = 0
        assignCards()
        revealAllCards()
        delay(1, hideCards)
    }
    
    func stepperValueChanged(stepper: UIStepper) {
        setupCards()
        shuffleCards()
    }

    lazy var cards = Card.fullDeck()
    func assignCards() {
        shuffle(&self.cards)
        var pairs = [Card]()
        
        pairs += self.cards[0 ..< self.pairsCount]
        pairs += pairs
        shuffle(&pairs)
        
        for (i, cardView) in enumerate(self.cardViews) {
            cardView.card = pairs[i]
        }
    }

    
    
    
    func showDialog() {
        let alert = UIAlertController(title: "赢了！", message: "再来一局", preferredStyle: UIAlertControllerStyle.Alert)
        
        let shuffle = UIAlertAction(title: "Shuffle", style: UIAlertActionStyle.Default, handler: {
            _ in
            self.shuffleCards()
        })
        
        alert.addAction(shuffle)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}

