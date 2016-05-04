//
//  Snake.swift
//  SillySnake
//
//  Created by 廖慶麟 on 2016/4/21.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class Snake {
    
    var snakeBody = Queue<Location>()
    var snakeDirection: String!
    init(){
        self.snakeDirection = "left"
        self.snakeBody.enQueue(Location(x: 210, y:100,direction: snakeDirection))
        self.snakeBody.enQueue(Location(x: 200, y:100,direction: snakeDirection))

    }
    
    func move(){

        switch snakeDirection {
            case "up":
                snakeBody.deQueue()
                snakeBody.enQueue(Location(x: snakeBody.peekBottom()!.value.x, y: snakeBody.peekBottom()!.value.y-10, direction: snakeDirection))
                break
            
            case "down":
                snakeBody.deQueue()
                snakeBody.enQueue(Location(x: snakeBody.peekBottom()!.value.x, y: snakeBody.peekBottom()!.value.y+10, direction: snakeDirection))
                break
            
            case "left":
                self.snakeBody.deQueue()
                self.snakeBody.enQueue(Location(x: snakeBody.peekBottom()!.value.x-10, y: snakeBody.peekBottom()!.value.y, direction: snakeDirection))
                break
            
            case "right":
                snakeBody.deQueue()
                snakeBody.enQueue(Location(x: snakeBody.peekBottom()!.value.x+10, y: snakeBody.peekBottom()!.value.y, direction: snakeDirection))
                break
            
            default:
                print("Error: Wrong Direction!")
        }
    }
    
    func grow(){
        let node = snakeBody.peekTop()?.value
        switch node!.direction! {
            case "up":
                snakeBody.grow(Location(x: node!.x, y: node!.y+10, direction: "up"))
                snakeBody.grow(Location(x: node!.x, y: node!.y+20, direction: "up"))
                break
            case "down":
                snakeBody.grow(Location(x: node!.x, y: node!.y-10, direction: "down"))
                snakeBody.grow(Location(x: node!.x, y: node!.y-20, direction: "down"))
                break
            case "left":
                snakeBody.grow(Location(x: node!.x+10, y: node!.y, direction: "left"))
                snakeBody.grow(Location(x: node!.x+20, y: node!.y, direction: "left"))
                break
            case "right":
                snakeBody.grow(Location(x: node!.x-10, y: node!.y, direction: "right"))
                snakeBody.grow(Location(x: node!.x-20, y: node!.y, direction: "right"))
                break
            default:
                print("Error: Wrong Direction!")
        }
    }
    
    func isSuicide() -> Bool{
        return snakeBody.isDuplicate(snakeBody.peekBottom()!.value)
    }
    
    func isEat(location: Location) -> Bool{
        if snakeBody.peekBottom()!.value.x == location.x && snakeBody.peekBottom()!.value.y == location.y {
            self.grow()
            return true
        }
        return false
    }
}


