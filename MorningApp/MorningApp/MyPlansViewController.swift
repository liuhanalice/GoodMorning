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
    @IBOutlet weak var timeupLabel: UILabel!
    
    
    func updateTime () {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        
        hourLabel.text = String(hour)
        minuteLabel.text = String(minutes)
        secondLabel.text = String(seconds)
    }
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        if !timer.isValid{
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(MyPlansViewController.letgo), userInfo: nil, repeats: true)
        }
        
    }
    func letgo()
    {
        if AddTaskViewController.totaltime2 <= 0
        {
            
            timer.invalidate()
            timeupLabel.text = "Time Up!时间到！"
        }
        else
        {
            AddTaskViewController.totaltime2 -= 1
            totalTimeLabel.text = String(AddTaskViewController.totaltime2)

        }
    }
   
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        timer.invalidate()
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        AddTaskViewController.totaltime2 = AddTaskViewController.totaltime
        totalTimeLabel.text = String(AddTaskViewController.totaltime2)
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
            
            
            
            totalTimeLabel.text = String(AddTaskViewController.totaltime2)
            
        }
        
    
        
        
        
    }
    
    
}


