//
//  Product.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 7/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import Foundation

struct Product: Codable, Hashable {
    
    var id: String
    var shopID: String
    var imageURL: String
    var title: String
    var description: String
    var price: Double
    var sale: Double
    
}
