//
//  Date++.swift
//  StoriesLMS
//
//  Created by  Denis Ovchar new on 21.05.2021.
//

import Foundation

public extension Date {
    func getDaysInMonth() -> Int{
        let calendar = Calendar.current
        
        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        return numDays
    }
}
