//
//  LLLabelNode.swift
//  LemonLime
//
//  Created by Kevin Wolkober on 10/17/15.
//  Copyright © 2015 Kevin Wolkober. All rights reserved.
//

import SpriteKit

class LLLabelNode: SKLabelNode {

    init(text: String = "", name: String = "", fontSize: CGFloat = 48.0, smallFontSize: CGFloat = 0, visible: Bool = true) {
        super.init()
        self.text = text
        self.name = name
        self.alpha = visible ? 1 : 0

        #if os(tvOS)
        self.fontSize = fontSize
        #else
        if smallFontSize > 0 {
            self.fontSize = smallFontSize
        } else {
            self.fontSize = fontSize * 0.52173913
        }
        #endif
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
}
