//
//  NewPlanViewController.swift
//  MorningApp
//
//  Created by 刘涵 on 2017/7/31.
//  Copyright © 2017年 刘涵. All rights reserved.
//

import Foundation
import UIKit
class NewPlanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    @IBOutlet weak var newplantableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var comeonLabel: UILabel!
   
    @IBOutlet weak var counttimeLabel: UILabel!
    
    var tasks : [Task] = []
    var timer = Timer()
    static var newtime:Int64 = 0
    static var countrow = 0
    var showtime = 0
    
    var showtimer = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        newplantableView.dataSource = self
        newplantableView.delegate = self
        
        }
     //NewPlanViewController.newtime = 0
     counttimeLabel.text = String(AddTaskViewController.totaltime2)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        newplantableView.reloadData()
        NewPlanViewController.newtime = 0
       
        for task:Task in tasks // add this to make sure the time showed on the cell couted only once
        {
            NewPlanViewController.newtime += task.time //here
        }
        AddTaskViewController.totaltime2 = NewPlanViewController.newtime
        print(AddTaskViewController.totaltime2)
       
        newplantableView.reloadData()
        //print("dad \(NewPlanViewController.countrow)")
        
    }
   
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    
   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create new table cell
        
        let cell = UITableViewCell()
        let titletext = "Title:     "
        let contenttext = "Content:   "
        let timetext = "Time:       "
        let timeunit = "  Min"
        
        
        let task = tasks[indexPath.row]
        cell.textLabel?.numberOfLines = 3
        
        cell.textLabel?.text = titletext+task.title!+"\n"+contenttext+task.content!+"\n"+timetext+String(task.time)+timeunit
        cell.textLabel?.textColor = UIColor .orange
        cell.textLabel?.font = UIFont.init(name: "Chalkduster", size: 13)
        
       
        changewords()
        return cell
        
        
        
    }
   
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete // when the table cell is deleted
        {
            let task = tasks[indexPath.row]
            AddTaskViewController.totaltime = AddTaskViewController.totaltime-task.time
            
            AddTaskViewController.totaltime2 = AddTaskViewController.totaltime2-task.time
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            NewPlanViewController.newtime = 0
            AddTaskViewController.totaltime2 = NewPlanViewController.newtime
            NewPlanViewController.countrow -= 1
            do
            {
                tasks = try context.fetch(Task.fetchRequest())}
            catch
            {
             print("Fetching Faild")
           }
            
            
    }
        tableView.reloadData()
       
    }
    
    
    
    
    func getData()->[Task]
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            tasks = try context.fetch(Task.fetchRequest())
            return tasks
        }
        catch{
            print("Fetching Faild")
        }
       return[]
        
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if !timer.isValid{
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewPlanViewController.letgo), userInfo: nil, repeats: true)
            
        }
        if !showtimer.isValid
        {
            
        showtimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(NewPlanViewController.countcount), userInfo: nil, repeats: true)
        }
   }
   
    func countcount()
    {
        showtime += 1
        timerLabel.text = String(showtime)
        changewords()
    }
    
    func letgo()
        
    {
        if AddTaskViewController.totaltime2 <= 0{
            timer.invalidate()
        }
            
        else{
            AddTaskViewController.totaltime2 -= 1
            counttimeLabel.text = String(AddTaskViewController.totaltime2)
        }
        
    }
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
           timer.invalidate()
        showtimer.invalidate()
            }
   
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
          timer.invalidate()
        showtimer.invalidate()
        showtime = 0
        timerLabel.text = String(showtime)
        
           AddTaskViewController.totaltime2 = NewPlanViewController.newtime
        
         counttimeLabel.text = String(AddTaskViewController.totaltime2)
        comeonLabel.text = "Come On!加油！～"

        

    }
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
       
    }
    
    func changewords()
    
    {
        print("1 \(Int64(showtime))")
        print("2 \(NewPlanViewController.newtime)")
       if Int64(showtime) >  NewPlanViewController.newtime
       {
           comeonLabel.text = "Congrats!完成啦～"
        }
    }
    
    
}
