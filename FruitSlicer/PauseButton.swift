//
//  PauseButton.swift
//  BaseProject
//
//  Created by Alex on 23/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit

class PauseButton: SKSpriteNode {
    
    // MARK: Private Properties
    
    private let pauseTexture = SKTexture(imageNamed: "pauseButton")
    private let resumeTexture = SKTexture(imageNamed: "resumeButton")
    private var gameIsPaused = false
    
    // MARK: Helper - Current Game State
    
    func getCurrentGameState() -> Bool {
        return gameIsPaused
    }
    
    // MARK: User Interaction - Handle Tap
    
    func handleTap() {
        gameIsPaused = !gameIsPaused
        self.texture = gameIsPaused ? resumeTexture : pauseTexture
    }
    
}
