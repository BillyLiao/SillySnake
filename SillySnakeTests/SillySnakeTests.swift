//
//  SillySnakeTests.swift
//  SillySnakeTests
//
//  Created by 廖慶麟 on 2016/4/21.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import XCTest
@testable import SillySnake

class SillySnakeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSnakeMove() {
        var snake = Snake()
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.x, 200)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.y, 100)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.direction, "left")
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.x, 210)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.y, 100)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.direction, "left")
        // Move left
        snake.move()
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.x, 190)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.y, 100)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.direction, "left")
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.x, 200)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.y, 100)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.direction, "left")
        // Move up
        snake.snakeDirection = "up"
        snake.move()
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.x, 190)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.y, 90)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.direction, "up")
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.x, 190)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.y, 100)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.direction, "left")
        snake.move()
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.x, 190)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.y, 80)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.direction, "up")
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.x, 190)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.y, 90)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.direction, "up")
        // Move rignt
        snake.snakeDirection = "right"
        snake.move()
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.x, 200)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.y, 80)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.direction, "right")
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.x, 190)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.y, 80)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.direction, "up")
        // Move down
        snake.snakeDirection = "down"
        snake.move()
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.x, 200)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.y, 90)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.direction, "down")
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.x, 200)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.y, 80)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.direction, "right")
        
    }
    
    func testSnakeGrow() {
        var snake = Snake()
        snake.grow()
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.x, 200)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.y, 100)
        XCTAssertEqual(snake.snakeBody.peekBottom()?.value.direction, "left")
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.x, 230)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.y, 100)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.direction, "left")
        // Grow after move
        snake.snakeDirection = "up"
        snake.move()
        snake.grow()
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.x, 240)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.y, 100)
        XCTAssertEqual(snake.snakeBody.peekTop()?.value.direction, "left")
    }
    
    func testSnakeSuicide() {
        var snake = Snake()
        snake.grow()
        snake.grow()
        XCTAssertEqual(snake.isSuicide(), false)
        snake.snakeDirection = "up"
        snake.move()
        snake.snakeDirection = "right"
        snake.move()
        snake.snakeDirection = "down"
        snake.move()
        XCTAssertEqual(snake.isSuicide(), true)
    }
    
    func testSnakeEat() {
        var snake = Snake()
        XCTAssertEqual(snake.isEat(Location(x: 190, y: 100, direction: "nil"))
, false)
        snake.move()
        XCTAssertEqual(snake.isEat(Location(x: 190, y: 100, direction: "nil")), true)
        
    }
    

    

    
}
