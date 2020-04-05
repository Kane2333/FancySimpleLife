//
//  Shop.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/29.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import Foundation

struct Shop: Codable, Hashable {
    
    var id: String
    var imageURL: String
    var title: String
    var secondaryTitle: String
    var distance: Double = 0
    var score: Double
    var location: [Double]
    var openingTime: String
    //var closeTime: String
    var category: String

}

