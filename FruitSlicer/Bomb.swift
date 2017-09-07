//
//  Bomb.swift
//  BaseProject
//
//  Created by Alex on 22/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit

class Bomb: SKSpriteNode {
    
    // MARK: Properties

    var isTouched : Bool = false
    
    // MARK: Private Properties
    
    private var bombSpark = SKEmitterNode(fileNamed: "BombSpark")!
    private var light: SKLightNode?

    convenience init() {
        let texture = SKTexture(imageNamed: "bomb")
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        setupBomb()
    }
    
    // MARK: Setup Bomb
    
    private func setupBomb() {
        
        self.size = CGSize(width: 100, height: 100)
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "bomb"), size: self.size)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = Collision.Bomb
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.friction = 70

        setupBombEffects()
    }
    
    // MARK: Setup Bomb Light Effects
    
    func setupBombEffects(){
        
        self.addChild(bombSpark)
        
        bombSpark.position = CGPoint(x: self.position.x, y: self.position.y+50)
        
        light = SKLightNode()
        
        if let light = self.light {
            light.position = CGPoint(x:0,y:0)
            light.falloff = 0.08
            light.ambientColor = UIColor.black
            light.shadowColor = UIColor.darkGray
            light.lightColor = UIColor.white
        }
        
    }
    
    // MARK: Update
    
    func update(delta: TimeInterval) {
        
        if self.position.y < 0 && self.physicsBody!.velocity.dy < CGFloat(0) {
            self.removeFromParent()
        }
    }

    
}
