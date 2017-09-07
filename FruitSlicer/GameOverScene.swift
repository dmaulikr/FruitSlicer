//
//  GameOverScene.swift
//  BaseProject
//
//  Created by Alex on 23/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    // MARK: Private Properties

    private var gameOverNode: SKNode?
    private var tryAgainButton: SKSpriteNode?
    private var currentScoreLabel: SKLabelNode?
    private var bestScoreLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        gameOverNode = self.childNode(withName: "gameOverNode")
        tryAgainButton = gameOverNode?.childNode(withName: "tryAgainButton") as? SKSpriteNode
        currentScoreLabel = gameOverNode?.childNode(withName: "currentScore") as? SKLabelNode
        bestScoreLabel = gameOverNode?.childNode(withName: "bestScore") as? SKLabelNode

    }
  
    // MARK: Update
    
    override func update(_ currentTime: TimeInterval) {
       
    }
    
    // MARK: User Interaction - Touches Began
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        
        guard let tryAgainButton = self.tryAgainButton else {
            return
        }
        
        if tryAgainButton.contains(touchLocation) {
            loadGameScene()
        }
    }
    
    // MARK: User Interaction - Load & Present Game Scene
    
    private func loadGameScene() {
        
        if let scene = SKScene(fileNamed: "GameScene") {
            scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(with: SKColor.black, duration: 1.0)
            view?.presentScene(scene, transition: transition)
        }
        
    }
}
