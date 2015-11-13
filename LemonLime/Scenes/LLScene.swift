//
//  LLScene.swift
//  LemonLime
//
//  Created by Kevin Wolkober on 10/2/15.
//  Copyright © 2015 Kevin Wolkober. All rights reserved.
//

import SpriteKit

class LLScene: SKScene {

    override func addChild(node: SKNode) {
        if node.respondsToSelector("willAddToParent:") {
            node.performSelector("willAddToParent:", withObject: self)
        }

        super.addChild(node)

        if node.respondsToSelector("didAddToParent:") {
            node.performSelector("didAddToParent:", withObject: self)
        }
    }
}
