//
//  MyPlansViewController.swift
//  MorningApp
//
//  Created by 刘涵 on 2017/8/2.
//  Copyright © 2017年 刘涵. All rights reserved.
//

import UIKit


class MyPlansViewController:UIViewController{
    

    var timer = Timer()
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
   
    

    
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
       // totalTimeLabel.text = String(AddTaskViewController.totaltime)
        
        
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
            
            
        }
              _ = Timer.scheduledTimer(timeInterval: 1, target:self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
            totalTimeLabel.text = String(NewPlanViewController.newtime)
           getData(city:"Beijing")
    }
  


func getData(city: String) {
    
    
    let urlString = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(String(describing: city))&units=metric&APPID=c10457489be06fbf428dbbb32ac7216a")
    
    //setup a "URL session" that handles the data that comes back from the api call
    let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
        do {
            if let data = data,
                
                //translate the data into a JSON object
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print(json) //print the entire json object retrieved from the url string
                
                //the following code parses through the JSON object, you can experiment here and try to print and get different values from the JSON object
                let main = json["main"] as! [String : Any]
                print(main)
                let wea = json["weather"] as! [Any]
                let temp2 = wea[0]
                
                
                let finalDictionary = temp2 as! [String : Any]
                let des = finalDictionary["description"] as! String
               
                
                
                let temp = main["temp"] as! Int
                print(temp)
                print(des)
                
                //once you have collected the data you need, you can now update any UI objects on your view controller
                DispatchQueue.main.async {
                    
                    self.temperatureLabel.text = String(temp) + "℃"
                    self.descriptionLabel.text = des
                }
                
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
    }
    task.resume()
    
}

}
