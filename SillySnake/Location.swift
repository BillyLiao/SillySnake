//
//  Location.swift
//  SillySnake
//
//  Created by 廖慶麟 on 2016/4/21.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class Location {
    
    var x: NSInteger!
    var y: NSInteger!
    var direction: String?
    
    init() {
        
    }
    
    init(x: NSInteger, y: NSInteger, direction: String) {
        self.x = x
        self.y = y
        self.direction = direction
    }
    
}
