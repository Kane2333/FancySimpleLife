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
    case drink
    case fun
    case travel
    case list
    
    var description: String {
        switch self {
        case .recommendation: return "推荐商家"
        case .food: return "吃的"
        case .drink: return "喝的"
        case .fun: return "玩的"
        case . travel: return "旅行"
        case .list: return "榜单"
        }
    }
}
