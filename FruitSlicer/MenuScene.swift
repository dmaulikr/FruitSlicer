//
//  MenuScene.swift
//  BaseProject
//
//  Created by Alex on 23/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    // MARK: Private Properties
    
    private var playButton: SKSpriteNode?
    private var logo: SKSpriteNode?
    private var title: SKLabelNode?
    private var menuNode: SKNode?
    
    // MARK: LifeCycle
    
    override func didMove(to view: SKView) {
        setupViews()
    }
    
    // MARK: Initialize Scene
    
    private func setupViews() {
        
        menuNode = self.childNode(withName: "menuNode")
        
        logo = menuNode?.childNode(withName: "logo") as? SKSpriteNode
        title = menuNode?.childNode(withName: "title") as? SKLabelNode
        playButton = menuNode?.childNode(withName: "playButton") as? SKSpriteNode
    }
    
    // MARK: User Interaction - Touches Began
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let location = touch.location(in: self)
        
        guard let playButton = self.playButton else {
            return
        }
        
        if playButton.contains(location) {
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
