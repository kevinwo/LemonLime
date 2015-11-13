//
//  LLSpriteNode.swift
//  LemonLime
//
//  Created by Kevin Wolkober on 10/25/15.
//  Copyright © 2015 Kevin Wolkober. All rights reserved.
//

import SpriteKit

protocol Animatable {
    func animate()
}

class LLSpriteNode: SKSpriteNode {

    init(imageNamed: String, size: CGSize = CGSizeZero) {
        let texture = SKTexture(imageNamed: imageNamed)
        let size = (size == CGSizeZero) ? texture.size() : size
        super.init(texture: texture, color: SKColor.clearColor(), size: size)
    }

    init(texture: SKTexture, size: CGSize = CGSizeZero) {
        super.init(texture: texture, color: SKColor.clearColor(), size: size)
    }

    init(color: SKColor, size: CGSize = CGSizeZero) {
        super.init(texture: nil, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addChild(node: SKNode) {
        if node.respondsToSelector("willAddToParent:") {
            node.performSelector("willAddToParent:", withObject: self)
        }

        super.addChild(node)

        if node.respondsToSelector("didAddToParent:") {
            node.performSelector("didAddToParent:", withObject: self)
        }
    }

    func resizeWithinNode(node: SKNode, scale: CGFloat) {
        let resizeFactor = self.size.width / self.size.height
        let height = node.frame.size.height * scale
        let width = height * resizeFactor
        self.size = CGSizeMake(width, height)
    }
}
