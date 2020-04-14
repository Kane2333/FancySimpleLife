//
//  SearchResult.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/12.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import Foundation

struct SearchResult: Codable, Hashable {
    var id: UUID
    var shopID: String
    var imageURL: String
    var title: String
    var description: String
    var distance: Double? = 0
    var score: Double?
    var location: [Double]?
    var price: Double?
    var originalPrice: Double?
    var eventStartDate: Date?
    var eventEndDate: Date?
    var kind: String
}
