//
//  LLLabelImageNode.swift
//  LemonLime
//
//  Created by Kevin Wolkober on 11/5/15.
//  Copyright © 2015 Kevin Wolkober. All rights reserved.
//

import SpriteKit

class LLLabelImageNode: LLLabelNode {

    var imageNode: SKSpriteNode

    init(text: String, name: String, fontSize: CGFloat, smallFontSize: CGFloat, imageNamed: String) {
        self.imageNode = SKSpriteNode(imageNamed: imageNamed)

        super.init(text: text, name: name, fontSize: fontSize, smallFontSize: smallFontSize)
        let multipler = self.frame.size.height < self.imageNode.size.height ? self.frame.size.height / self.imageNode.size.height : 1.0
        self.imageNode.size = CGSizeMake(self.imageNode.size.width * multipler, self.frame.size.height)
        self.addChild(imageNode)
        self.imageNode.positionAt(self.column(8) + (self.imageNode.size.width * 0.75), y: self.center().y * 0.75)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var text: String? {
        didSet {
            self.imageNode.positionAt(self.column(8) + (self.imageNode.size.width * 0.75), y: self.center().y * 0.75)
        }
    }

    override func didAddToParent(parent: SKNode) {
        self.positionAt(self.position.x - (self.imageNode.size.width * 0.75), y: self.position.y)
    }
}
