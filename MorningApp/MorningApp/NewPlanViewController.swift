//
//  NewPlanViewController.swift
//  MorningApp
//
//  Created by 刘涵 on 2017/7/31.
//  Copyright © 2017年 刘涵. All rights reserved.
//

import Foundation
import UIKit
class NewPlanViewController:UITableViewController{
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
