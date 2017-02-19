//
//  ViewController.swift
//  日期计算器
//
//  Created by 周河晓 on 2017/2/13.
//  Copyright © 2017年 周河晓. All rights reserved.
//

import UIKit

//全局变量要在这里声明
var theDifferentTime : Int = 0
var switchedLabelText : String = ""

class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet weak var datePicker2: UIDatePicker!
    @IBOutlet weak var outputLabel: UILabel!
    
    //计算按钮
    @IBAction func calculatorButton(_ sender: AnyObject) {
        
        //获得date picker的数值
        let theDate1 : NSDate = self.datePicker1.date as NSDate
        let theDate2 : NSDate = self.datePicker2.date as NSDate
        
        //转换时间戳
        let dateStamp1 : TimeInterval = theDate1.timeIntervalSince1970
        let dateStamp2 : TimeInterval = theDate2.timeIntervalSince1970
        
        //调用计算时间戳差值的函数
        let differTime = differentDateCounter(dateStamp1: Int(dateStamp1), dateStamp2: Int(dateStamp2))
        theDifferentTime = differTime//把值扔给全局变量，方便在后面调用
        
        print(" \n theDifferntTime = \(theDifferentTime)")
        
        /*
        if (differTime > 2147472000 ){
            func popupAlertView(_ sender: AnyObject) {
                let alertView : UIAlertView = UIAlertView(title: "计算的时间太长了哦", message: "", delegate: self, cancelButtonTitle: "明了")
                alertView.show()
            }
        }
        */
        
        //时间差（天数）格式输出到标签
        let reslutLabelText : String = reslutLabelTextCalculate(differTime: theDifferentTime)
        self.outputLabel.text = reslutLabelText + "天"
    }
    
    //计算时间差值的函数
    func differentDateCounter(dateStamp1 : Int, dateStamp2 : Int) -> Int{
        
        if(dateStamp2 < dateStamp1){
            let currentDateStamp : Int = Int(dateStamp1)
            let setDateStamp : Int = Int(dateStamp2)
            
            let differTime = currentDateStamp - setDateStamp
            return differTime
        }else{
            let currentDateStamp : Int = Int(dateStamp2)
            let setDateStamp : Int = Int(dateStamp1)
            
            let differTime = currentDateStamp - setDateStamp
            return differTime
        }
    }
    
    //时间戳转换为天数的函数
    func reslutLabelTextCalculate(differTime : Int) -> String{
        
        let howManyDays : Int = Int(differTime / 86400)//24 * 60 * 60 = 86400，一天就这么多秒
        
        let howManyDay : String = String(howManyDays)
        print(" howManyDay = \(howManyDay) days")
        return howManyDay
    }
    
    
    //长按转换标签数据
    @IBAction func foundLongPress(_ sender: AnyObject) {
        
        print("long press")//妈个鸡，顶上控件按control拉到标签，label按住control往上面的LongPress控件上拖
        
        let paramSender = sender as! UILongPressGestureRecognizer
        if (paramSender.state == .began && self.outputLabel.text != "时间差"){
            dateFormatSwitch()
            self.outputLabel.text = switchedLabelText
        }
    }
    //单击还原标签数据
    @IBAction func foundTap(_ sender: AnyObject) {
        
        print("tap")
        
        let paramSender = sender as! UITapGestureRecognizer
        if (paramSender.state == .ended){
            self.outputLabel.text = reslutLabelTextCalculate(differTime: theDifferentTime)
        }
    }
    
    //转换日期格式的函数
    func dateFormatSwitch() -> Void{
        
        let howManyDays = Int(theDifferentTime / 86400)
        
        if (howManyDays >= 365){
            
            var outputDateFormat : String = ""
            
            let years = howManyDays / 365
            let restOfTime = howManyDays % 365
            
            let restOfMonths = restOfTime / 30
            let restOfDays = restOfTime % 30
            
            if(restOfTime >= 30){
                
                if(restOfDays != 0 && restOfMonths != 0){
                    
                    outputDateFormat = String(years) + "年" + String(restOfMonths) + "个月" + String(restOfDays) + "天"
                    switchedLabelText = outputDateFormat

                }
                if(restOfDays == 0 && restOfMonths != 0){
                    
                    outputDateFormat = String(years) + "年" + String(restOfMonths) + "个月"
                    switchedLabelText = outputDateFormat

                }
                
            }
            if(restOfTime < 30){
                
                if(restOfDays != 0 && restOfMonths == 0){
                    
                    outputDateFormat = String(years) + "年" + String(restOfDays) + "天"
                    switchedLabelText = outputDateFormat

                }
                if(restOfDays == 0 && restOfMonths == 0){
                    
                    outputDateFormat = String(years) + "年"
                    switchedLabelText = outputDateFormat
                    
                }
                
            }
            
        }
        if(howManyDays < 365){
            
            var outputDateFormat : String = ""
            
            let months = howManyDays / 30
            let restOfDays = howManyDays % 30
            
            if(restOfDays != 0 && months != 0){
                
                outputDateFormat = String(months) + "个月" + String(restOfDays) + "天"
                switchedLabelText = outputDateFormat

            }
            if(restOfDays == 0 && months != 0){
                
                outputDateFormat = String(months) + "个月"
                switchedLabelText = outputDateFormat

            }
            if(restOfDays != 0 && months == 0){
                
                outputDateFormat = "不到一个月"
                switchedLabelText = outputDateFormat

            }
        }
        
    }

    
}

    
    
    
    
    
    
    
    
    



