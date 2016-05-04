//
//  Queue.swift
//  SillySnake
//
//  Created by 廖慶麟 on 2016/4/21.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class QNode<T> {
    var value: T
    var next: QNode?
    
    init(item: T){
        value = item
    }
}

public struct Queue<T> {

    private var top: QNode<T>!
    private var bottom: QNode<T>!
    
    init(){
        top = nil
        bottom = nil
    }
    mutating func enQueue(item: T){
        
        var newNode:QNode<T> = QNode(item: item)
        
        if top == nil {
            top = newNode
            bottom = top
            return
        }
        
        bottom.next = newNode
        bottom = newNode
    }
    
    mutating func deQueue() -> T?{
        
        let topItem: T? = top?.value
        
        if topItem == nil {
            return nil
        }
        
        if let nextItem = top.next {
            top = nextItem
        }else {
            top = nil
            bottom = nil
        }
        
        return topItem
    }
    
    mutating func grow(item: T){
        var newNode:QNode<T> = QNode(item: item)
        
        newNode.next = top
        top = newNode
    }
    
    func length() -> Int {
        var currNode: QNode<T>!
        var length: Int = 0
        currNode = top
        while currNode != nil {
            length++
            currNode = currNode.next
        }
        return length
    }
    
    func isDuplicate(item: T) -> Bool {
        var currNode: QNode<T>!
        currNode = top
        print(self.length())
        for _ in 1...self.length()-1 {
            if ((currNode?.value as! Location).x ==  (item as! Location).x)&&((currNode?.value as! Location).y ==  (item as! Location).y){
                return true
            }
                currNode = currNode?.next
        }
        return false
    }
    
    func isEmpty() -> Bool {
        return top == nil ? true : false
    }
    
    func peekTop() -> QNode<T>! {
        return top
    }
    
    func peekBottom() -> QNode<T>!{
        return bottom
    }
}
