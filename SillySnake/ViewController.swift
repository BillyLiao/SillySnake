//
//  ViewController.swift
//  SillySnake
//
//  Created by 廖慶麟 on 2016/4/21.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SnakeViewDelegate{
    
    var snake = Snake.init()
    var fruit = Location()
    var gameView = GameView()
    var timer: NSTimer!
    var xBound: UInt32!
    var yBound: UInt32!
    var startButton: UIButton!

    @IBOutlet var swipeDown: UISwipeGestureRecognizer!
    @IBOutlet var swipeUp: UISwipeGestureRecognizer!
    @IBOutlet var swipeLeft: UISwipeGestureRecognizer!
    @IBOutlet var swipeRight: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xBound = UInt32(self.view.frame.width)
        yBound = UInt32(self.view.frame.height)
        
        let gViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        gameView.frame = gViewFrame
        self.view.addSubview(gameView)
        
        //Random the First fruit
        fruit.x = Int(arc4random_uniform(xBound/10)) * 10
        fruit.y = Int(arc4random_uniform(yBound/10)) * 10

        
        
        startButton = UIButton(frame: CGRect(x: self.view.frame.width/2 - 50, y: self.view.frame.height/2, width: 100, height: 40))
        startButton.setTitle("Start", forState: .Normal)
        startButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        startButton.hidden = false
        startButton.addTarget(self, action: "gameStart", forControlEvents: .TouchUpInside)
        gameView.addSubview(startButton)

        // Set gameView delegate to self(UIViewController)
        
        gameView.delegate = self

    }

    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGameView() {
        if snake.isEat(fruit){
            // If the fruit is eaten, then refresh the fruit
            fruit.x = Int(arc4random_uniform(xBound/10)) * 10
            fruit.y = Int(arc4random_uniform(yBound/10)) * 10
        }
        if snake.isSuicide(){
            gameOver()
        }

        snake.move()
        checkOutOfRange()
        gameView.setNeedsDisplay()
    }
    
    
    func viewDidRequestSnake(sender: GameView) -> Snake {
        return snake
    }
    
    func viewDidRequestFruit(sender: GameView) -> Location {
        return fruit
    }
    
    @IBAction func swipe(sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.Right:
            lockSwipeDirection(sender)
            snake.snakeDirection = "right"
            break
        case UISwipeGestureRecognizerDirection.Left:
            lockSwipeDirection(sender)
            snake.snakeDirection = "left"
            break
        case UISwipeGestureRecognizerDirection.Up:
            lockSwipeDirection(sender)
            snake.snakeDirection = "up"
            break
        case UISwipeGestureRecognizerDirection.Down:
            lockSwipeDirection(sender)
            snake.snakeDirection = "down"
        default:
            break
        }
    }
    
    func gameStart() {
        startButton.hidden = true
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "updateGameView", userInfo: nil, repeats: true)
    }
    
    func gameRefresh() {
        // Reset the game
        self.snake = Snake()
        
        swipeUp.enabled = true
        swipeDown.enabled = true
        swipeLeft.enabled = true
        swipeRight.enabled = true

        fruit.x = Int(arc4random_uniform(xBound/10)) * 10
        fruit.y = Int(arc4random_uniform(yBound/10)) * 10
        gameStart()
    }
    
    func gameOver() {
        timer.invalidate()
        
        var alertController = UIAlertController(title: "", message: "You Lose!", preferredStyle: .Alert)
        let restartAction = UIAlertAction(title: "Restart the Game", style: .Default) { (alert: UIAlertAction) -> Void in
            self.gameRefresh()
        }
        alertController.addAction(restartAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func lockSwipeDirection(swipeGesture: UISwipeGestureRecognizer){
        swipeUp.enabled = true
        swipeDown.enabled = true
        swipeLeft.enabled = true
        swipeRight.enabled = true
        switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                swipeLeft.enabled = false
                swipeRight.enabled = false
            case UISwipeGestureRecognizerDirection.Left:
                swipeLeft.enabled = false
                swipeRight.enabled = false
            case UISwipeGestureRecognizerDirection.Up:
                swipeUp.enabled = false
                swipeDown.enabled = false
            case UISwipeGestureRecognizerDirection.Down:
                swipeUp.enabled = false
                swipeDown.enabled = false
            default:
                break
        }
    }
    
    // If the snake is bumping the wall, then go out from the other side.
    func checkOutOfRange(){
        var snake = self.snake
        let head = snake.snakeBody.peekBottom().value
        let frameSize = self.view.frame
        if head.x < 0{
            snake.snakeBody.deQueue()
            snake.snakeBody.enQueue(Location(x: Int(frameSize.width)-(10+Int(head.x)), y: head.y, direction: head.direction!))
        }else if head.x > Int(frameSize.width){
            snake.snakeBody.deQueue()
            snake.snakeBody.enQueue(Location(x: 0+Int(head.x)-Int(frameSize.width)-10, y: head.y, direction: head.direction!))
        }else if head.y < 0{
            snake.snakeBody.deQueue()
            snake.snakeBody.enQueue(Location(x: head.x, y: Int(frameSize.height)-(10+Int(head.y)), direction: head.direction!))
        }else if head.y > Int(frameSize.height){
            snake.snakeBody.deQueue()
            snake.snakeBody.enQueue(Location(x: head.x, y: 0+Int(head.y)-Int(frameSize.height)-10, direction: head.direction!))
        }
    }
}

