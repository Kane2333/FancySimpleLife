//
//  Date+Ext.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/5.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import Foundation

extension Date {
    
    func converToYearMonthDayFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
