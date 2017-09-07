//
//  GameScene.swift
//  BaseProject
//
//  Created by Alex on 21/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: Private Properties
    
    private enum GameState {
        case Menu
        case Running
        case Paused
        case GameOver
    }
    
    private var gameState: GameState = .Running
    private var previousGameState: GameState = .Running
    private var pauseButton : PauseButton?

    // MARK: Properties
    
    var lastUpdateTime: TimeInterval = 0.0
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var screenFrame: CGRect = CGRect.zero
    var spawnPoint: CGPoint = CGPoint.zero
    var score: Int = 0
    var life: Int = 3
    var scoreLabel: SKLabelNode?
    var lifeLabel: SKLabelNode?
    var flashBackground: SKSpriteNode?
    var blackBackground: SKSpriteNode?
    var ninjaBackground: SKSpriteNode?
    var combo: [Fruit] = []
    var timerLabel: SKLabelNode?
    var time: Int = 60
    var isMovingFinger: Bool = false
    var fruitNode: SKNode = SKNode()
    var blade: Blade = Blade(radius: 5.0)
    var fruitGenerator = FruitGenerator()
    var bombGenerator = BombGenerator()
    
    // MARK: LifeCycle

    override func didMove(to view: SKView) {
        setupNotifications()
        setupViews()
    }
    
    // MARK: Setup Notifications
    
    private func setupNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(paused), name: NSNotification.Name(rawValue: "ShouldPause"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resumeGame), name: NSNotification.Name(rawValue: "ShouldResume"), object: nil)
    }
    
    // MARK: Setup Views
    
    func setupViews() {
        
        bombGenerator.bombDelegate = self
        
        blackBackground = self.childNode(withName: "blackBackground") as? SKSpriteNode
        blackBackground?.alpha = 1.0
        
        ninjaBackground = self.childNode(withName: "ninjaBackground") as? SKSpriteNode
        ninjaBackground?.lightingBitMask = 1
        ninjaBackground?.alpha = 0.0
        
        pauseButton = self.childNode(withName: "pauseButton") as? PauseButton
        
        flashBackground = self.childNode(withName: "flashBackground") as? SKSpriteNode
        
        timerLabel = self.childNode(withName: "timerLabel") as? SKLabelNode
        
        if let timerLabel = self.scoreLabel {
            timerLabel.text = "00:60"
        }
        
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        
        if let scoreLabel = self.scoreLabel {
            scoreLabel.text = String(describing: score)
        }
        
        lifeLabel = self.childNode(withName: "lifeLabel") as? SKLabelNode
        
        if let lifeLabel = self.lifeLabel {
            lifeLabel.text = "\(life) lifes"
        }
        
        self.addChild(fruitNode)
        
        blade.bladeLight.targetNode = self
        
        physicsWorld.contactDelegate = self
        
        if let view = self.view {
            screenFrame = view.frame
            screenWidth = screenFrame.width
            screenHeight  = screenFrame.height
        }
        
        spawnPoint = CGPoint(x: self.size.width/2, y: 100)
        
        self.addChild(fruitGenerator)
        self.addChild(bombGenerator)
        
        running()
    }
    
    // MARK: Update

    override func update(_ currentTime: TimeInterval) {
        
        let delta = currentTime - lastUpdateTime
        
        lastUpdateTime = currentTime
        
        checkGameState(delta: delta)
        
        if time > 9 {
            timerLabel?.text = "00:\(self.time)"
        } else if time == 9 {
            timerLabel?.text = "00:09"
        }  else if time == 8 {
            timerLabel?.text = "00:08"
        } else if time == 7 {
            timerLabel?.text = "00:07"
        } else if time == 6 {
            timerLabel?.text = "00:06"
        } else if time == 5 {
            timerLabel?.text = "00:05"
        } else if time == 4 {
            timerLabel?.text = "00:04"
        } else if time == 3 {
            timerLabel?.text = "00:03"
        } else if time == 2 {
            timerLabel?.text = "00:02"
        } else if time == 1 {
            timerLabel?.text = "00:01"
        } else if time == 0 {
            timerLabel?.text = "00:00"
            gameOver()
        }
        
    }
    
    // MARK: Game State
    
    func checkGameState(delta: TimeInterval) {
        
        switch gameState {
            
        case .Menu: return
            
        case .Running:
            
            fruitGenerator.update(delta: delta)
            bombGenerator.update(delta: delta)
            
        case .Paused: return
            
        case .GameOver: return
        }
        
    }
    
    // MARK: User Interaction - Touch Down
    
    func touchDown(atPoint pos : CGPoint) {
        
        guard let pauseButton = self.pauseButton else {
            return
        }
        
        if pauseButton.contains(pos) {
            handlePauseTapped()
        } else if gameState == .Running {
            blade.position = pos
            blade.removeFromParent()
            self.addChild(blade)
            ninjaBackground?.alpha = 1.0
            blackBackground?.alpha = 0.0
        }
        
        isMovingFinger = false
        combo.removeAll()
    }
    
    // MARK: User Interaction - Touch Moved
    
    func touchMoved(toPoint pos : CGPoint) {
        blade.position = pos
        isMovingFinger = true
    }
    
    // MARK: User Interaction - Touch Up
    
    func touchUp(atPoint pos : CGPoint) {
        blade.removeFromParent()
        ninjaBackground?.alpha = 0.0
        blackBackground?.alpha = 1.0
        
        isMovingFinger = false
        combo.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    // MARK: Loose One Life
    
    func looseOneLife() {
        
        life -= 1
        
        if life <= 0 {
            if gameState != .GameOver {
                lifeLabel?.text = "0 life"
                gameOver()
            }
        }
        
        if life == 1 {
            lifeLabel?.text = "\(life) life"
        }
        
        if life > 1 {
            lifeLabel?.text = "\(life) lifes"
        }
    }
    
    // MARK: Did Slice Fruit
    
    func didSliceFruit(fruit: Fruit) {
        
        if !fruit.isSliced {
            
            fruit.isSliced = true
            
            score += 1
            scoreLabel?.text = String(describing: score)
            
            guard let juice = fruit.juice else {
                return
            }
            
            self.addChild(juice)
            
            guard let leftSlice = fruit.leftSlice, let rightSlice = fruit.rightSlice else {
                return
            }
            
            fruitNode.addChild(leftSlice)
            fruitNode.addChild(rightSlice)
            
            leftSlice.physicsBody?.applyImpulse(CGVector(dx: -80, dy: -29))
            rightSlice.physicsBody?.applyImpulse(CGVector(dx: +72, dy: -38))
            
            fruit.removeFromParent()
        }
    }
    
    // MARK: Did Hit Bomb
    
    func didHitBomb(bomb: Bomb) {
        
        if !bomb.isTouched {
            
            bomb.isTouched = true
            
            looseOneLife()
            
            flash()
            
            let bombExploSequenceAnimation = SKAction.sequence([Constants.juiceFadoutAction, Constants.juiceRemoveAction])
            
            let bombExplosion  = SKEmitterNode(fileNamed: "BombExplosion")!
            bombExplosion.position = bomb.position
            
            fruitNode.addChild(bombExplosion)
            
            bombExplosion.run(bombExploSequenceAnimation)
            
            let bombSequAnimation = SKAction.sequence([SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()])
            
            bomb.run(bombSequAnimation)
        }
    }

    // MARK: Flash
    
    private func flash() {
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.2)
        let fadeOut = SKAction.fadeOut(withDuration: 0.2)
        
        flashBackground?.run(SKAction.sequence([fadeIn, fadeOut]))
    }
    
    // MARK: Timer Start
    
    private func startTimer() {
        
        let actionwait = SKAction.wait(forDuration: 1.0)
        
        let actionrun = SKAction.run({
            self.time -= 1
        })
        
        timerLabel?.run(SKAction.repeatForever(SKAction.sequence([actionrun, actionwait])), withKey: "timerKey")
    }
    
    // MARK: Timer Stop
    
    private func stopTimer() {
        timerLabel?.removeAction(forKey: "timerKey")
    }
    
    // MARK: Game Is Running Setup
    
    private func running() {
        gameState = .Running
        startTimer()
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
    }
    
    // MARK: Game Is Paused Setup
    
    func paused() {
        previousGameState = gameState
        gameState = .Paused
        self.speed = 0.0
        self.physicsWorld.gravity = CGVector.zero
        self.physicsWorld.speed = 0.0
    }
    
    // MARK: Game Did Resumed Setup
    
    func resume() {
        
        gameState = previousGameState
        
        self.speed = 1.0
        
        if previousGameState == .Running  || previousGameState == .GameOver  {
            self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        } else {
            self.physicsWorld.gravity = CGVector.zero
        }
        self.physicsWorld.speed = 1.0
        
    }
    
    // MARK: Resume Game
    
    func resumeGame() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(resume), userInfo: nil, repeats: false)
    }
    
    // MARK: User Interaction - Pause/Resume Tapped
    
    private func handlePauseTapped() {
        
        pauseButton?.handleTap()
        
        if pauseButton!.getCurrentGameState() {
            paused()
            stopTimer()
            self.isPaused = true
        } else {
            startTimer()
            resume()
            self.isPaused = false
        }
    }
    
    // MARK: Game Over
    
    private func gameOver() {
        
        self.run(SKAction.wait(forDuration: 0), completion: {
            [weak self] in
            self?.loadGameOverScene()
        })
    }
    
    // MARK: Load & Present Game Over Scene
    
    private func loadGameOverScene() {
        
        if let scene = SKScene(fileNamed: "GameOverScene") {
            scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(with: SKColor.black, duration: 0.75)
            self.view?.presentScene(scene, transition: transition)
        }
    }

}

extension GameScene: BombDelegate {
    
    // MARK: BombDelegate
    
    func bombIsOnScreen() {
        ninjaBackground?.alpha = 1.0
        blackBackground?.alpha = 0.0
        print("on screen")
    }
    
    func bombIsNotOnScreen() {
        ninjaBackground?.alpha = 0.0
        blackBackground?.alpha = 1.0
        print("left the screen")
        
    }

}


extension GameScene: SKPhysicsContactDelegate {
    
    // MARK: SKPhysicsContactDelegate
 
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == Collision.Blade && secondBody.categoryBitMask == Collision.Bomb {
            
            guard let bomb = secondBody.node as? Bomb else {
                return
            }
            
            combo.removeAll()
            
            didHitBomb(bomb: bomb)
        }
        
        if firstBody.categoryBitMask == Collision.Blade && secondBody.categoryBitMask == Collision.Fruit {
            
            guard let slashedFruit = secondBody.node as? Fruit else {
                return
            }
            
            didSliceFruit(fruit: slashedFruit)
        }
    }
    
}







