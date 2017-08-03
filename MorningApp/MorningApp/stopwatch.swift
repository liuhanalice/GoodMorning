//
//  stopwatch.swift
//  MorningApp
//
//  Created by 刘涵 on 2017/8/3.
//  Copyright © 2017年 刘涵. All rights reserved.
//

import Foundation

class Stopwatch{
    
    private var startTime: NSDate?
    var elapsdTime: TimeInterval {
        if let startTime = self.startTime{
            return -startTime.timeIntervalSinceNow
            
        }
        else{
            return 0
        }
    }
    
    var isRunning: Bool
    {
        return startTime != nil
    }
    
    func start()
    {
        startTime = NSDate()
    }
    
    func stop()
    {
        startTime = nil
    }
    
}
