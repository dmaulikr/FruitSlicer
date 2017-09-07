//
//  Constants.swift
//  BaseProject
//
//  Created by Alex on 21/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit
import GameplayKit

struct Constants {
    
    static let screenSize: CGSize = CGSize(width: 1334, height: 750)
    static let screenHeight: CGFloat = 750
    static let screenWidth: CGFloat = 1334
    static let screenCenter = CGPoint(x: screenWidth / 2, y: screenHeight / 2)

    static let bananaSize = CGSize(width: 180.0, height: 90.0)
    static let bananaSliceSize = bananaSize
    
    static let watermelonSize = CGSize(width: 150, height: 150)
    static let waterelonSliceSize = watermelonSize

    static let kiwiSize = CGSize(width: 90.0, height: 90.0)
    static let kiwiSliceSize = kiwiSize

    static let bananaFullName = "bananaFull"
    static let bananaRightSliceName = "bananaRight"
    static let bananaLeftSliceName = "bananaLeft"
    
    static let watermelonFullName = "watermelonFull"
    static let watermelonRightSliceName = "watermelonRight"
    static let watermelonLeftSliceName = "watermelonLeft"
    
    static let kiwiFullName = "kiwiFull"
    static let kiwiRightSliceName = "kiwiRight"
    static let kiwiLeftSliceName = "kiwiLeft"
    
    static let sliceFadoutAction = SKAction.fadeOut(withDuration: 2.5)
    static let sliceRemoveAction = SKAction.removeFromParent()
    
    static let juiceFadoutAction = SKAction.fadeOut(withDuration: 3.0)
    static let juiceRemoveAction = SKAction.removeFromParent()

    static let spawnA = CGPoint(x: screenSize.width/2, y:  -60)
    static let spawnB = CGPoint(x: screenSize.width/2 - (screenSize.width/2)*80/100, y: -60)
    static let spawnC = CGPoint(x: screenSize.width/2 + (screenSize.width/2)*80/100, y: -60)
}


