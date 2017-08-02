//
//  AddTaskViewController.swift
//  MorningApp
//
//  Created by 刘涵 on 2017/8/1.
//  Copyright © 2017年 刘涵. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    
    
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
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ExerciseButtonTapped(_ sender: UIButton) {
        titleTextField.text = "Exercise 锻炼"
    }
    
    

}

