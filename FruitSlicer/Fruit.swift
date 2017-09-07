//
//  Fruit.swift
//  BaseProject
//
//  Created by Alex on 21/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit

class Fruit: SKSpriteNode {
    
    enum FruitFamily {
        case kiwi
        case watermelon
        case banana
    }
    
    // MARK: Properties
    
    var isSliced: Bool = false {
        didSet {
            selectSlices()
            setupSlices()
            setupJuice()
        }
    }
    
    var leftSlice: SKSpriteNode?
    var rightSlice: SKSpriteNode?
    var juice: SKEmitterNode?
    var fruitFamily: FruitFamily = .kiwi
    
    // MARK: Private Properties
    
    private var kiwiFull = SKSpriteNode(imageNamed: "kiwiFull")
    private var kiwiLeft = SKSpriteNode(imageNamed: "kiwiLeft")
    private var kiwiRight = SKSpriteNode(imageNamed: "kiwiRight")
    
    private var watermelonFull = SKSpriteNode(imageNamed: "watermelonFull")
    private var watermelonLeft = SKSpriteNode(imageNamed: "watermelonLeft")
    private var watermelonRight = SKSpriteNode(imageNamed: "watermelonRight")
    
    private var bananaFull = SKSpriteNode(imageNamed: "bananaFull")
    private var bananaLeft = SKSpriteNode(imageNamed: "bananaLeft")
    private var bananaRight = SKSpriteNode(imageNamed: "bananaRight")

    // MARK: Initializers
    
    convenience init(fruitFamily: FruitFamily) {
        
        var texture = SKTexture()
        
        switch fruitFamily {
        case .kiwi: texture = SKTexture(imageNamed: "kiwiFull")
        case .watermelon: texture = SKTexture(imageNamed: "watermelonFull")
        case .banana: texture = SKTexture(imageNamed: "bananaFull")
        }
        
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        
        self.fruitFamily = fruitFamily
        
        setupFruit()
    }
    
    // MARK: Setup Fruit
    
    private func setupFruit() {
        
        switch fruitFamily {
            
        case .kiwi:
            
            self.size = Constants.kiwiSize
            self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "kiwiFull"), size: self.size)
            
        case .watermelon:
            
            self.size = Constants.watermelonSize
            self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "kiwiFull"), size: self.size)
            
        case .banana:
            
            self.size = Constants.bananaSize
            self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "bananaFull"), size: self.size)
            
        }
        
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = Collision.Fruit
        self.physicsBody?.collisionBitMask = 0
    }
  
    // MARK: Select Fruit Slices
    
    private func selectSlices() {
        
        switch fruitFamily {
            
        case .kiwi:
            
            leftSlice = SKSpriteNode(imageNamed: Constants.kiwiLeftSliceName)
            rightSlice = SKSpriteNode(imageNamed: Constants.kiwiRightSliceName)
            
        case .banana:
            
            leftSlice = SKSpriteNode(imageNamed: Constants.bananaLeftSliceName)
            rightSlice = SKSpriteNode(imageNamed: Constants.bananaRightSliceName)
            
        case .watermelon:
            
            leftSlice = SKSpriteNode(imageNamed: Constants.watermelonLeftSliceName)
            rightSlice = SKSpriteNode(imageNamed: Constants.watermelonRightSliceName)
            
        }
        
    }
    
    // MARK: Setup Slides
    
    private func setupSlices() {
        
        guard let leftSlice = self.leftSlice, let rightSlice = self.rightSlice else {
            return
        }
        
        switch fruitFamily {
            
        case .kiwi:
            
            leftSlice.size = Constants.kiwiSliceSize
            rightSlice.size = Constants.kiwiSliceSize
            leftSlice.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Constants.kiwiLeftSliceName), size: leftSlice.size)
            rightSlice.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Constants.kiwiRightSliceName), size: rightSlice.size)
            
        case .banana:
            
            leftSlice.size = Constants.bananaSliceSize
            rightSlice.size = Constants.bananaSliceSize
            leftSlice.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Constants.bananaLeftSliceName), size: leftSlice.size)
            rightSlice.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Constants.bananaRightSliceName), size: rightSlice.size)
            
            
        case .watermelon:
            
            leftSlice.size = Constants.waterelonSliceSize
            rightSlice.size = Constants.waterelonSliceSize
            leftSlice.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Constants.watermelonLeftSliceName), size: leftSlice.size)
            rightSlice.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: Constants.watermelonRightSliceName), size: rightSlice.size)
            
        }
        
        leftSlice.physicsBody?.affectedByGravity = true
        leftSlice.physicsBody?.isDynamic = true
        leftSlice.physicsBody?.allowsRotation = true
        leftSlice.physicsBody?.collisionBitMask = 0
        
        rightSlice.physicsBody?.affectedByGravity = true
        rightSlice.physicsBody?.isDynamic = true
        rightSlice.physicsBody?.allowsRotation = true
        rightSlice.physicsBody?.collisionBitMask = 0
        rightSlice.zPosition = 2.0
        
        leftSlice.position = self.position
        rightSlice.position = self.position
        
        let slicesSequenceAction = SKAction.sequence([Constants.sliceFadoutAction, Constants.sliceRemoveAction])
        
        leftSlice.run(slicesSequenceAction)
        rightSlice.run(slicesSequenceAction)
        
    }
    
    // MARK: Setup Juice
    
    private func setupJuice() {
        
        let juiceSequenceAction = SKAction.sequence([Constants.juiceFadoutAction, Constants.juiceRemoveAction])
        
        switch fruitFamily {
            
        case .kiwi:
            
            juice  = SKEmitterNode(fileNamed: "GreenJuice")

        case .banana:
            
            juice  = SKEmitterNode(fileNamed: "YellowJuice")
            
        case .watermelon:
            
            juice  = SKEmitterNode(fileNamed: "RedJuice")
            
        }
        
        guard let juice = self.juice else {
            return
        }
        
        juice.position = self.position
        juice.run(juiceSequenceAction)
    }
    
    // MARK: Update
    
    func update(delta: TimeInterval) {
        
        if self.position.y < 0 && self.physicsBody!.velocity.dy < CGFloat(0) {
            self.removeFromParent()
        }
        
    }
    
    
    
}
