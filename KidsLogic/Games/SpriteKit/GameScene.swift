//
//  GameScene.swift
//  SpriteKitGame
//
//  Created by macbookpro on 12/07/2018.
//  Copyright © 2018 Anish. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene ,SKPhysicsContactDelegate{
    
    var coinMan : SKSpriteNode?
    var coinTimer :Timer?
    var bombTimer : Timer?
  //  var ground : SKSpriteNode?
    var sealing : SKSpriteNode?
    var scoreLabel : SKLabelNode?
    var yourFinalScoreLabel: SKLabelNode?
    var youScoreLabel: SKLabelNode?
    
    var score = 0
 
    //create cetogary for each object
    
    let coinManCategory : UInt32 = 0x1 << 1
     let coinCategory : UInt32 = 0x1 << 2
     let bombCategory : UInt32 = 0x1 << 3
    let grondAndSealCategory : UInt32 = 0x1 << 4
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        coinMan = childNode(withName: "coinMan") as? SKSpriteNode
        
        coinMan?.physicsBody?.categoryBitMask = coinManCategory
        coinMan?.physicsBody?.contactTestBitMask = coinCategory | bombCategory
        coinMan?.physicsBody?.collisionBitMask = grondAndSealCategory
        //animation for running man gifs
        var coinManRun:[SKTexture] = []
        
        for number in 1...5
        {
            coinManRun.append(SKTexture(imageNamed: "frame-\(number)"))
        }
        
        coinMan?.run(SKAction.repeatForever(SKAction.animate(with: coinManRun, timePerFrame: 0.09)))
        
        
//        ground = childNode(withName: "ground") as? SKSpriteNode
//        ground?.physicsBody?.categoryBitMask = grondAndSealCategory
//        ground?.physicsBody?.collisionBitMask = coinManCategory
        
        sealing = childNode(withName: "seal") as? SKSpriteNode
        sealing?.physicsBody?.categoryBitMask = grondAndSealCategory
        sealing?.physicsBody?.collisionBitMask = coinManCategory
        
        scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode
        
        makeTimer()
        createGrass()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
      
        
        if contact.bodyA.categoryBitMask == coinCategory
        {
            contact.bodyA.node?.removeFromParent()
            score += 1
            scoreLabel?.text = "SCORE : \(score)"
        }
        if contact.bodyB.categoryBitMask == coinCategory
        {
            contact.bodyB.node?.removeFromParent()
            score += 1
            scoreLabel?.text = "SCORE : \(score)"
        }
        if contact.bodyA.categoryBitMask == bombCategory
        {
            gameOver()
        }
        if contact.bodyB.categoryBitMask == bombCategory
        {
            gameOver()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        coinMan?.physicsBody?.applyForce(CGVector(dx: 0, dy: 100_000))
        
        let touch = touches.first
        
        if let location = touch?.location(in: self)
        {
            let theNode = nodes(at: location)
            
            for node in theNode
            {
                if node.name == "play"
                {
                    score = 0
                    node.removeFromParent()
                    
                    youScoreLabel?.removeFromParent()
                    yourFinalScoreLabel?.removeFromParent()
                    scene?.isPaused = false
                    scoreLabel?.text = "Your score \(score)"
                    makeTimer()
                }
            }
        }
        
        
    }
    
    func createGrass () {
        
        let grassSizing = SKSpriteNode(imageNamed: "grass")
        let grassSize = Int(size.width / grassSizing.size.width) + 1
        
        for number in 0...grassSize
        {
            let grass = SKSpriteNode(imageNamed: "grass")
            grass.physicsBody = SKPhysicsBody(rectangleOf: grass.size)
            grass.physicsBody?.categoryBitMask = grondAndSealCategory
            grass.physicsBody?.collisionBitMask = coinManCategory
            grass.physicsBody?.isDynamic = false
            grass.physicsBody?.affectedByGravity = false
            addChild(grass)
            
            //gras position
            let grassX = -size.width / 2 + grass.size.width + grass.size.width * CGFloat(number)
            let grassY =  -size.width / 2 + grass.size.width / 2 - 18
            
            grass.position = CGPoint(x: grassX, y: grassY)
            
            // grass animation to move
            let grassSpeed  = 100.0
            let firstMoveLeft = SKAction.moveBy(x: -grass.size.width - grass.size.width * CGFloat(number), y: 0, duration: TimeInterval( grass.size.width + grass.size.width * CGFloat(number)) / grassSpeed)
            
            let resetGrass = SKAction.moveBy(x: size.width + grass.size.width, y: 0, duration: 0)
            
            let grassFullMove = SKAction.moveBy(x: -size.width - grass.size.width, y: 0, duration: TimeInterval(size.width + grass.size.width) / grassSpeed)
            
            let grassMovingForever = SKAction.repeatForever(SKAction.sequence([grassFullMove,resetGrass]))
            
            grass.run(SKAction.sequence([firstMoveLeft,resetGrass,grassMovingForever]))
            
        }
        
    }
    
    
    func makeTimer () {
        
        coinTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.makeCoin()
        })
        
        bombTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
            self.createBomb()
        })
        
    }

    
    func gameOver () {
        
        scene?.isPaused = true
        coinTimer?.invalidate()
        bombTimer?.invalidate()
        
         youScoreLabel = SKLabelNode(text: "Your score")
        youScoreLabel?.position = CGPoint(x: 0, y: 200 )
        youScoreLabel?.fontSize = 160
        youScoreLabel?.zPosition = 1
        if youScoreLabel != nil {
        addChild(youScoreLabel!)
        }
         yourFinalScoreLabel = SKLabelNode(text: "\(score)")
        yourFinalScoreLabel?.position = CGPoint(x: 0, y: 0 )
        yourFinalScoreLabel?.fontSize = 200
        yourFinalScoreLabel?.zPosition = 1
        if yourFinalScoreLabel != nil {
        addChild(yourFinalScoreLabel!)
        }
        let playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x: 0, y: -200)
        playButton.name = "play"
        // to come on top in screen
        playButton.zPosition = 1
        addChild(playButton)
        
    }
    
  
    
 
    
    func makeCoin () {
        
        let coin = SKSpriteNode(imageNamed: "coin")
        // add physics body for coin
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.affectedByGravity = false
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.contactTestBitMask = coinManCategory
        addChild(coin)
        
        // random heights for different coins
        
        let maxY = size.height / 2 - coin.size.height / 2
        let minY = -size.height / 2 + coin.size.height / 2
        let range = maxY - minY
        let coinY  = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        coin.position = CGPoint(x: size.width / 2 + coin.size.width / 2 , y: coinY)
        
        let coinMoveLeft = SKAction.moveBy(x: -size.width - #imageLiteral(resourceName: "coin").size.width, y: 0, duration: 2)
        
        coin.run(SKAction.sequence([coinMoveLeft,SKAction.removeFromParent()]))
        
        
    }
    
    func createBomb () {
        
        let bomb = SKSpriteNode(imageNamed: "bomb")
        // add physics body for coin
        bomb.physicsBody = SKPhysicsBody(rectangleOf: bomb.size)
        bomb.physicsBody?.affectedByGravity = false
        bomb.physicsBody?.categoryBitMask = bombCategory
        bomb.physicsBody?.contactTestBitMask = coinManCategory
        addChild(bomb)
        
        // random heights for different coins
        
        let maxY = size.height / 2 - bomb.size.height / 2
        let minY = -size.height / 2 + bomb.size.height / 2
        let range = maxY - minY
        let bombY  = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        bomb.position = CGPoint(x: size.width / 2 + bomb.size.width / 2 , y: bombY)
        
        let bombMoveToLeft = SKAction.moveBy(x: -size.width - #imageLiteral(resourceName: "bomb").size.width, y: 0, duration: 2)
        
        bomb.run(SKAction.sequence([bombMoveToLeft,SKAction.removeFromParent()]))
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
