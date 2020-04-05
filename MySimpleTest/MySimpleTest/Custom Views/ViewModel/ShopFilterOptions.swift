//
//  ShopFilterOptions.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/28.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import Foundation

enum ShopFilterOptions: Int, CaseIterable {
    case recommendation
    case food
    case fresh
    case fun
    case travel
    case list
    
    var description: String {
        switch self {
        case .recommendation: return "推荐"
        case .food: return "餐饮"
        case .fresh: return "生鲜"
        case .fun: return "娱乐"
        case . travel: return "旅行"
        case .list: return "榜单"
        }
    }
}
