//: ## Ahoy!
//: #### In this playground, you will go in a journey through the amazing world of Pi approximation. Come with me!
//: [Continue](@next)

import SpriteKit
import PlaygroundSupport

var count = 0

enum ColliderType: UInt32 {
    case Wall = 1
    case Floor = 2
    case Box1 = 4
    case Box2 = 8
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var wall: SKSpriteNode!
    private var floor: SKSpriteNode!
    private var box1: SKSpriteNode!
    private var box2: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        
        wall = SKSpriteNode(color: SKColor.black, size: CGSize(width: 10, height: self.frame.height))
        wall.position = CGPoint(x: 100, y: self.frame.height/2)
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.frame.size)
        wall.physicsBody?.isDynamic = false
        
        floor = SKSpriteNode(color: SKColor.black, size: CGSize(width: self.frame.width, height: 10))
        floor.position = CGPoint(x: self.frame.width/2, y: 100)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.frame.size)
        floor.physicsBody?.isDynamic = false
        
        box1 = SKSpriteNode(color: SKColor.black, size: CGSize(width: 100, height: 100))
        box1.position = CGPoint(x: 300, y: floor.position.y+box1.size.height/2)
        box1.physicsBody = SKPhysicsBody(circleOfRadius: box1.frame.size.width/2)
        
        box2 = SKSpriteNode(color: SKColor.black, size: CGSize(width: 100, height: 100))
        box2.position = CGPoint(x: 750, y: floor.position.y+box2.size.height/2)
        box2.physicsBody = SKPhysicsBody(circleOfRadius: box2.frame.size.width/2)
        
        self.addChild(wall)
        self.addChild(floor)
        self.addChild(box1)
        self.addChild(box2)
        self.physicsWorld.contactDelegate = self
        
        self.view?.showsPhysics = true
        
        box1.physicsBody?.allowsRotation = false
        box2.physicsBody?.allowsRotation = false
        
        box1.physicsBody?.restitution = 1
        box2.physicsBody?.restitution = 1
        
        box1.physicsBody?.mass = 1
        box2.physicsBody?.mass = 100
        
        box1.physicsBody?.friction = 0
        box2.physicsBody?.friction = 0
        
        box1.physicsBody?.linearDamping = 0
        box2.physicsBody?.linearDamping = 0
        
        wall.physicsBody?.categoryBitMask = ColliderType.Wall.rawValue
        box1.physicsBody?.categoryBitMask = ColliderType.Box1.rawValue
        box2.physicsBody?.categoryBitMask = ColliderType.Box2.rawValue
        
        box1.physicsBody?.collisionBitMask = ColliderType.Wall.rawValue | ColliderType.Floor.rawValue | ColliderType.Box2.rawValue
        box2.physicsBody?.collisionBitMask = ColliderType.Floor.rawValue | ColliderType.Box1.rawValue
        
        box1.physicsBody?.contactTestBitMask = ColliderType.Box2.rawValue | ColliderType.Wall.rawValue
        
        
        box1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        box2.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        count = count + 1
        print(count-1)
    }
}

let sceneView = SKView(frame: CGRect(x: 0 , y: 0, width: 800, height: 600))
let scene = GameScene(size: CGSize(width: 800, height: 600))
sceneView.presentScene(scene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
