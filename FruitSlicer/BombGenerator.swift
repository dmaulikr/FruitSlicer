//
//  BombGenerator.swift
//  BaseProject
//
//  Created by Alex on 22/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol BombDelegate: class  {
    func bombIsOnScreen()
    func bombIsNotOnScreen()
}

class BombGenerator: SKNode {    
    
    var bombDelegate: BombDelegate?
    
    private var interval: TimeInterval = 0.0
    
    private var bomb: Bomb?
    private var bombCopy: Bomb?
    
    func generateBomb() {
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        
        bomb = Bomb()
        
        bombCopy = bomb?.copy() as? Bomb
        
        if let bombCopy = self.bombCopy {
            
            self.addChild(bombCopy)
            
            bombCopy.position = Constants.spawnA
            
            bombCopy.physicsBody?.applyImpulse(CGVector(dx: CGFloat(GKRandomDistribution(lowestValue: 60, highestValue: 90).nextInt()), dy: CGFloat(GKRandomDistribution(lowestValue: 130, highestValue: 180).nextInt())))
            
        }
        
    }
    
    
    func update(delta: TimeInterval) {
        
        interval += delta
        
        if interval >= 1.0 {
            
            let randomNumber = GKRandomDistribution(lowestValue: 0, highestValue: 100).nextInt()
            
            if randomNumber >= 92 {
                generateBomb()
            }
            interval = 0.0
        }
        
        for node in self.children {
            
            if let bomb = node as? Bomb {
                
                bomb.update(delta: delta)
                
//                bombDelegate?.bombIsOnScreen()

//                if bomb.position.y > 0 && bomb.physicsBody!.velocity.dy > CGFloat(0) {
//                    bombDelegate?.bombIsOnScreen()
//                }
//                
//                if bomb.position.y < 0 && bomb.physicsBody!.velocity.dy < CGFloat(0) {
//                    bombDelegate?.bombIsNotOnScreen()
//                }
//            
                
            }
            
        }
        
    }
    
    
}
