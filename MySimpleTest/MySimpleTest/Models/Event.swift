//
//  Event.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 7/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import Foundation

struct Event: Codable, Hashable {
    
    var id: String
    var shopID: String
    var title: String
    var startDate: Date
    var endDate: Date
    var description: String
    var imageURL: String
    var price: Double
    var originalPrice: Double
}
