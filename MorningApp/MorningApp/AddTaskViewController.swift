//
//  AddTaskViewController.swift
//  MorningApp
//
//  Created by 刘涵 on 2017/8/1.
//  Copyright © 2017年 刘涵. All rights reserved.
//

import UIKit
class AddTaskViewController: UIViewController {
   
    
       static var totaltime:Int64 = 0
       static var totaltime2:Int64 = 0
    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Task(context: context)
        
        task.title = titleTextField.text
        task.content = contentTextField.text
        task.time = Int64(timeTextField.text!) ?? 0
        //print(task.totaltimecore)
        
        task.totaltimecore += task.time
        //AddTaskViewController.totaltime2 += task.time
        
       
      
        AddTaskViewController.totaltime = task.totaltimecore
        AddTaskViewController.totaltime2 = task.totaltimecore
        //print(task.totaltimecore)

        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ExerciseButtonTapped(_ sender: UIButton) {
        titleTextField.text = "Exercise 锻炼"
    }
    
    @IBAction func tidyupButtonTapped(_ sender: UIButton) {
        titleTextField.text = "Tidy UP 整理"
    }
    
    @IBAction func washingButtonTapped(_ sender: UIButton) {
        titleTextField.text = "Washing 洗漱"
    }
    @IBAction func dressingButtonTapped(_ sender: Any) {
        titleTextField.text = "Dressing 着装"
    }

    @IBAction func makeupButtonTapped(_ sender: UIButton) {
        titleTextField.text = "Make Up 化妆"
    }
    @IBAction func breakfastButtonTapped(_ sender: UIButton) {
        titleTextField.text = "Breakfast 早餐"
    }
    
}

