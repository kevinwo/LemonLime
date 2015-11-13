//
//  LLTimerBarNode.swift
//  LemonLime
//
//  Created by Kevin Wolkober on 11/4/15.
//  Copyright © 2015 Kevin Wolkober. All rights reserved.
//

import SpriteKit

protocol LLTimerBarNodeDelegate : NSObjectProtocol {
    func timerDidFinish(timerBarNode: LLTimerBarNode)
}

class LLTimerBarNode: LLSpriteNode {

    var originalWidth: CGFloat
    var timer: NSTimer?
    var autoDecrementBy: CGFloat = 0
    var time: NSTimeInterval
    weak var delegate: LLTimerBarNodeDelegate?
    let timerFireSelector = NSSelectorFromString("timerFinished")

    init(color: SKColor, size: CGSize, time: NSTimeInterval, delegate: LLTimerBarNodeDelegate?) {
        self.originalWidth = size.width
        self.time = time
        self.delegate = delegate

        super.init(color: color, size: size)
        self.zPosition = 100
        self.anchorPoint = CGPointMake(0, 0.5)
        self.autoDecrementBy = size.width / CGFloat(time)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fire() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(self.time, target: self, selector: self.timerFireSelector, userInfo: nil, repeats: true)
        self.runAction(SKAction.repeatActionForever(SKAction.resizeByWidth(-self.autoDecrementBy, height: 0, duration: 1.0)))
    }

    func isCountingDown() -> Bool {
        return self.size.width > 0 ? true : false
    }

    func pause() {
        self.timer?.invalidate()
    }

    func resume() {
        let remainingSecondsCalculator = self.size.width / self.originalWidth
        let seconds = self.time * NSTimeInterval(remainingSecondsCalculator)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: self.timerFireSelector, userInfo: nil, repeats: false)
    }

    func timerFinished() {
        self.delegate?.timerDidFinish(self)
    }
}
