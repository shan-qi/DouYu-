//
//  Date+Extension.swift
//  DouYuTV
//
//  Created by 单琦 on 2018/5/17.
//  Copyright © 2018年 单琦. All rights reserved.
//

import Foundation

extension Date{
    //pragma mark: -获取当前年
    func getYear() ->Int {
        let calendar = NSCalendar.current
        //这里注意 swift要用[,]这样方式写
        let year = calendar.component(.year, from: self)
        return year
    }
    //pragma mark: -获取当前月
    func getMonth() ->String {
        let calendar = NSCalendar.current
        //这里注意 swift要用[,]这样方式写
        let month = calendar.component(.month, from: self)
        let monthStr = String(format: "%02d",month)
        return monthStr
    }
    //pragma mark: -获取当前的天
    func getDay() ->String {
        let calendar = NSCalendar.current
        //这里注意 swift要用[,]这样方式写
        let day = calendar.component(.day, from: self)
        let dayStr = String(format: "%02d",day)
        return dayStr
    }
    //pragma mark: -获取星期几
    func weekDay() -> String{
        let weekDays = [NSNull.init(),"星期日","星期一","星期二","星期三","星期四","星期五","星期六"] as [Any]
        let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
        let timeZone = NSTimeZone.init(name: "Asia/Shanghai")
        calendar?.timeZone = timeZone! as TimeZone
        let calendarUnit = NSCalendar.Unit.weekday
        let theComponents = calendar?.components(calendarUnit, from: self)
        return weekDays[(theComponents?.weekday)!] as! String
    }
    
}
