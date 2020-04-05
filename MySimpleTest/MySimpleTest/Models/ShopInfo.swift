//
//  ShopInfo.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/3/31.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import Foundation

import Foundation


struct ShopInfo: Codable, Hashable {
    var shopID: String
    var shopImageURL: String
    var shopTitle: String
    var shopAddress: String
    var shopOpeningTime: String
    var eventID: String
    var eventTitle: String
    var eventDescription: String
    var eventStartDate: Date
    var eventEndDate: Date
    var eventPrice: Double
    var eventOriginalPirce: Double
    var eventImageURL: String
    var productImageURLs: [String]
    var reviewUsername: String?
    var reviewAvatarImageURL: String?
    var reviewContent: String?
    var reviewImageURLs: [String]?
    var reviewAmount: Int
    var reviewLikeAmount: Double?
    var recommendShopIDs: [String]
    var recommendShopTitles: [String]
    var recommendShopImages: [String]
    var recommendShopScores: [Double]
    
}
