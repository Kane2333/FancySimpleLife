//
//  FLError.swift
//  MySimpleTest
//
//  Created by YIPIN JIN on 28/3/20.
//  Copyright © 2020 RickJin. All rights reserved.
//

import Foundation

enum FLError: String, Error {
    case invalidUsername        = "This username created an invalid request. Please try again."
    case unableToComplete       = "Unable to complete your request. Please check you Internet connection."
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "从服务器获取的数据无效，请稍后再次尝试。"
    case unableToFavourite      = "There was an eror favouriting this user. Please try again"
    case alreadyInFavourites    = "You've already favourited this user. You must REALLY like them!"
}
