//
//  FruitGenerator.swift
//  BaseProject
//
//  Created by Alex on 21/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit
import GameplayKit

class FruitGenerator: SKNode {
    
    var leftSlice: SKSpriteNode?
    var rightSlice: SKSpriteNode?
    
    private var interval: TimeInterval = 0.0
    
    private let kiwi = Fruit(fruitFamily: .kiwi)
    private let banana = Fruit(fruitFamily: .banana)
    private let watermelon = Fruit(fruitFamily: .watermelon)
    private var fruits = [Fruit]()
    
    private var randomFruit: Fruit?
    private var randomFruitCopy: Fruit?
    
    var spawnArray = [Constants.spawnA, Constants.spawnB, Constants.spawnC]
    
    
    func generateFruit() {
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        
        fruits = [kiwi, banana, watermelon]
        
        fruits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: fruits) as! [Fruit]
        
        randomFruit = fruits[0]
        
        randomFruitCopy = randomFruit?.copy() as? Fruit
        
        
        guard let randomFruit = self.randomFruit, let randomFruitCopy = self.randomFruitCopy else {
            return
        }
        
        
        randomFruitCopy.fruitFamily = randomFruit.fruitFamily
        
        self.addChild(randomFruitCopy)
        
        
        
        spawnArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: spawnArray) as! [CGPoint]
        
        let randomSpawnPoint = spawnArray[0]
        
        randomFruitCopy.position = randomSpawnPoint
        
        
        var fruitMultiplier: CGFloat = 1.0  // will allow us to adjust the impulse depending on the fruit size
        
        switch randomFruit {
            
        case kiwi:
            
            fruitMultiplier = 1.0
            
        case banana:
            
            fruitMultiplier = 1.20
            
        case watermelon:
            
            fruitMultiplier = 2.48
            
        default: fatalError("Error: Fruit doesn't exist")
            
        }
        
        
        let spawnA_Impulse = CGVector(dx: CGFloat(GKRandomDistribution(lowestValue: 25/2, highestValue: 95/2).nextInt()), dy: CGFloat(GKRandomDistribution(lowestValue: 175, highestValue: 190).nextInt()))
        
        let spawnB_Impulse = CGVector(dx: CGFloat(GKRandomDistribution(lowestValue: 25, highestValue: 80).nextInt()), dy: CGFloat(GKRandomDistribution(lowestValue: 175, highestValue: 190).nextInt()))
        
        let spawnC_Impulse = vectorXMultiply(v: CGVector(dx: CGFloat(GKRandomDistribution(lowestValue: 25, highestValue: 80).nextInt()), dy: CGFloat(GKRandomDistribution(lowestValue: 175, highestValue: 190).nextInt())), k: -1)
        
        
        switch randomSpawnPoint {
            
        case Constants.spawnA:
            
            randomFruitCopy.physicsBody?.applyImpulse(vectorXYMultiply(v: spawnA_Impulse, k: fruitMultiplier))
            
        case Constants.spawnB:
            
            randomFruitCopy.physicsBody?.applyImpulse(vectorXYMultiply(v: spawnB_Impulse, k: fruitMultiplier))
            
        case Constants.spawnC:
            
            randomFruitCopy.physicsBody?.applyImpulse(vectorXYMultiply(v: spawnC_Impulse, k: fruitMultiplier))
            
        default: fatalError("Error: Spawn Point doesn't exist")
            
        }
        
        
        
    }
    
    
    
    
    func update(delta: TimeInterval) {
        
        interval += delta
        
        
        var randomIntervals = [0.85, 1.0, 4.0]
        randomIntervals = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: randomIntervals) as! [Double]
        
        let randomInterval = randomIntervals[0]

        
        if interval >= randomInterval {
            generateFruit()
            interval = 0.0
        }
        
        for node in self.children {
            
            if let fruit = node as? Fruit {
                fruit.update(delta: delta)
            }
            
        }
        
    }
    
    
}
