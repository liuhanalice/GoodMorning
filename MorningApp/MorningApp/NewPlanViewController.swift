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
    
    
    @IBOutlet var newplantableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var tasks : [Task] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        newplantableView.dataSource = self
        newplantableView.delegate = self
        
        }
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        newplantableView.reloadData()
    }
   
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    
   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell()
        let titletext = "Title       标题: "
        let contenttext = "Content 内容: "
        let timetext = "Time      时间: "
        let timeunit = "  Min分钟"
        
        
        let task = tasks[indexPath.row]
        cell.textLabel?.numberOfLines = 3
        
        cell.textLabel?.text = titletext+task.title!+"\n"+contenttext+task.content!+"\n"+timetext+String(task.time)+timeunit
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete
        {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
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
    
    
    
    
    func getData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            tasks = try context.fetch(Task.fetchRequest())
        }
        catch{
            print("Fetching Faild")
        }
    }
    
    
   
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
        

}
