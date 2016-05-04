//
//  GameView.swift
//  SillySnake
//
//  Created by 廖慶麟 on 2016/4/22.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

protocol SnakeViewDelegate: class {
    // sender is the one who want to find a deputy(代理人)
    func viewDidRequestSnake(sender: GameView) -> Snake
    func viewDidRequestFruit(sender: GameView) -> Location
}

class GameView: UIView {
    
    // keeping track of the delegate to use later
    
    weak var delegate: SnakeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func drawRect(rect: CGRect) {
        
        // In the example, means ViewController?.viewDidRequestSnake(sender: GameView)
        //                       ViewController?.viewDidRequestFruit(sender: GameView)
        let snake: Snake = (delegate?.viewDidRequestSnake(self))!
        let fruit: Location = (delegate?.viewDidRequestFruit(self))!
        
        var currNode = snake.snakeBody.peekTop()
        while currNode != nil {
            let drect = CGRect(x: currNode!.value.x, y: currNode!.value.y, width: 10, height: 10)
            let bpath:UIBezierPath = UIBezierPath(rect: drect)
            let color = UIColor.whiteColor()
            color.set()
            bpath.stroke()
            currNode = currNode?.next
        }
        
        let drect = CGRect(x: fruit.x, y: fruit.y, width: 10, height: 10)
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        let color = UIColor.yellowColor()
        
        color.set()
        bpath.stroke()
        
    }
}
