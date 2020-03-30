//
//  TuanGo.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit

struct TuanGo: Codable, Hashable {
    
    var id: String
    var title: String
    var secondaryTitle: String
    var amount: Double
    var price: Double
    var originalPrice: Double
    var imageURL: String
/*
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
     */
}
