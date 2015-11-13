//
//  LLExtensions.swift
//  LemonLime
//
//  Created by Kevin Wolkober on 11/10/15.
//  Copyright © 2015 Kevin Wolkober. All rights reserved.
//

import SpriteKit

enum PhysicsBodyType: Int {
    case Rectangle
    case Circle
}

extension CGFloat {
    func degreesToRadians() -> CGFloat {
        return self * CGFloat(M_PI / 180)
    }
}

extension SKLabelNode {
    func adjustFontSizeToFitRect(rect: CGRect) {
        let scalingFactor = min(rect.width / self.frame.width, rect.height / self.frame.height)
        self.fontSize *= scalingFactor
    }
}

extension SKNode {
    func willAddToParent(parent: SKNode) {}
    func didAddToParent(parent: SKNode) {}

    func distanceTo(node: SKNode) -> CGFloat {
        return sqrt(abs(pow((self.position.x - node.position.x), 2) - pow((self.position.y - node.position.y), 2)))
    }

    func positionAt(x: CGFloat, y: CGFloat) {
        self.position = CGPointMake(x, y)
    }

    func center() -> CGPoint {
        return CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
    }

    func row(number: Int) -> CGFloat {
        return self.frame.size.height * self.widthHeightMultiplier(number)
    }

    func column(number: Int) -> CGFloat {
        return self.frame.size.width * self.widthHeightMultiplier(number)
    }

    private func widthHeightMultiplier(number: Int) -> CGFloat {
        switch number {
        case 1:
            return 0.0625
        case 2:
            return 0.125
        case 3:
            return 0.1875
        case 4:
            return 0.25
        case 5:
            return 0.3125
        case 6:
            return 0.375
        case 7:
            return 0.4375
        case 8:
            return 0.5
        case 9:
            return 0.5625
        case 10:
            return 0.625
        case 11:
            return 0.6875
        case 12:
            return 0.75
        case 13:
            return 0.8125
        case 14:
            return 0.875
        case 15:
            return 0.9475
        case 16:
            return 1.0
        default:
            return 0
        }
    }

    func makeCollidable(category: UInt32, collidingObjects: UInt32?, gravity: Bool = false, pinned: Bool = false, rotation: Bool = false, circleRadius: CGFloat = 0, bodyType: PhysicsBodyType = .Rectangle, offset: CGPoint = CGPointMake(0, 0)) {

        switch bodyType {
        case .Rectangle:
            self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size, center: offset)
        case .Circle:
            self.physicsBody =  SKPhysicsBody(circleOfRadius: circleRadius, center: offset)
        }

        self.physicsBody?.dynamic = true
        self.physicsBody?.affectedByGravity = gravity
        self.physicsBody?.pinned = pinned
        self.physicsBody?.allowsRotation = rotation
        self.physicsBody?.categoryBitMask = category

        if (collidingObjects != nil) {
            self.physicsBody?.collisionBitMask = category | collidingObjects!
            self.physicsBody?.contactTestBitMask =
                category | collidingObjects!
        }
    }
}

extension SKAction {
    class func rainbowtize() -> SKAction {
        let red = SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 0.5, duration: 4.0 )
        let green = SKAction.colorizeWithColor(SKColor.greenColor(), colorBlendFactor: 0.5, duration: 4.0 )
        let blue = SKAction.colorizeWithColor(SKColor.blueColor(), colorBlendFactor: 0.5, duration: 4.0 )
        let orange = SKAction.colorizeWithColor(SKColor.orangeColor(), colorBlendFactor: 0.5, duration: 4.0 )
        let magenta = SKAction.colorizeWithColor(SKColor.magentaColor(), colorBlendFactor: 0.5, duration: 4.0 )
        let purple = SKAction.colorizeWithColor(SKColor.purpleColor(), colorBlendFactor: 0.5, duration: 4.0 )

        return SKAction.repeatActionForever(sequence([red, green, blue, orange, magenta, purple]))
    }

    class func shake() -> SKAction {
        let rotateRight = SKAction.rotateByAngle(0.2, duration: 0.25)
        rotateRight.timingMode = .EaseIn
        let rotateLeft = SKAction.rotateByAngle(-0.4, duration: 0.25)
        rotateLeft.timingMode = .EaseInEaseOut
        let rotateCenter = SKAction.rotateByAngle(0.2, duration: 0.25)
        rotateCenter.timingMode = .EaseOut

        return SKAction.repeatActionForever(sequence([rotateRight, rotateLeft, rotateCenter]))
    }

    class func wiggle() -> SKAction {
        let rotateRight = SKAction.rotateToAngle(0.05, duration: 0.4)
        rotateRight.timingMode = .EaseIn
        let rotateLeft = SKAction.rotateToAngle(-0.05, duration: 0.4)
        rotateLeft.timingMode = .EaseOut

        return SKAction.repeatActionForever(sequence([rotateRight, rotateLeft]))
    }
}

extension SKScene {
    func didMakeContact(contact: SKPhysicsContact, name1: String, name2: String) -> Bool {
        let firstNode = contact.bodyA.node
        let secondNode = contact.bodyB.node

        if (firstNode!.name == name1 && secondNode!.name == name2 ||
            firstNode!.name == name2 && secondNode!.name == name1) {
                return true
        }

        return false
    }
}

extension String {
    func breakApartWithUppercaseSpaces() -> String {
        var index = 1
        let mutableInputString: NSMutableString = NSMutableString(string: self)

        while (index < mutableInputString.length) {
            if NSCharacterSet.uppercaseLetterCharacterSet().characterIsMember(mutableInputString.characterAtIndex(index)) {
                mutableInputString.insertString(" ", atIndex:index)
                index++
            }
            index++
        }

        return mutableInputString as String
    }
}
