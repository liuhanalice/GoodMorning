//
//  MyPlansViewController.swift
//  MorningApp
//
//  Created by 刘涵 on 2017/8/2.
//  Copyright © 2017年 刘涵. All rights reserved.
//

import UIKit


class MyPlansViewController:UIViewController{
    
    //var mytime = AddTaskViewController.totaltime2
    var timer = Timer()
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func updateTime () {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        dateLabel.text = String(year)+"."+String(month)+"."+String(day)
        totalTimeLabel.text = String(AddTaskViewController.totaltime)
        
        
        hourLabel.text = String(hour)
        minuteLabel.text = String(minutes)
        secondLabel.text = String(seconds)
        
    }
            override func viewDidLoad() {
        super.viewDidLoad()
        updateTime()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            //let timer = Timer.init(timeInterval: 1, target: self, selector: Selector.init("updateTime"), userInfo: nil, repeats: true)
            _ = Timer.scheduledTimer(timeInterval: 1, target:self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
           
           

           
            
        }
        
    
        
        
        
    }
    
    
}


