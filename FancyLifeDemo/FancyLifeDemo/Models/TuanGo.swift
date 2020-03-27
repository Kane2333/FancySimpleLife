//
//  TuanGo.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import Foundation
import UIKit

struct TuanGo: Codable, Hashable {
    var title: String
    var secondaryTitle: String
    var amount: Int
    var price: Double
    var originalPrice: Double
    var imageName: String
}
