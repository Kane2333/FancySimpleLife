//
//  TuanGo.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import Foundation
 
struct AdImage: Codable, Hashable {
    var id: String
    var imageURL: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
