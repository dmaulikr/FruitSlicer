//
//  Blade.swift
//  BaseProject
//
//  Created by Alex on 21/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit

class Blade: SKNode {
    
    // MARK: Private Properties
    
    private var light: SKLightNode?
    
    // MARK: Properties
    
    var bladeLight = SKEmitterNode(fileNamed: "Sword")!
   
    // MARK: Intializers

    convenience init(radius: CGFloat) {
        self.init()
        setupPhysics(radius: radius)
        setupBladeLight()
    }
    
    // MARK: Setup Blade Physics
    
    private func setupPhysics(radius: CGFloat) {
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = Collision.Blade
        self.physicsBody?.contactTestBitMask = Collision.Fruit | Collision.Bomb
        self.physicsBody?.collisionBitMask = 0
    }
    
    // MARK: Setup Blade Light Effect
    
    func setupBladeLight(){
        
        self.addChild(bladeLight)
        
        bladeLight.position = self.position
        
        light = SKLightNode()
        
        if let light = self.light {
            light.position = CGPoint(x:0,y:0)
            light.falloff = 1.0
            light.ambientColor = UIColor.black
            light.shadowColor = UIColor.darkGray
            light.lightColor = UIColor.white
            self.addChild(light)
        }
        
    }
    
    // MARK: Did Slash Fruit

    func didSlash(fruit: Fruit) {
        // TODO
    }
    
    
}

