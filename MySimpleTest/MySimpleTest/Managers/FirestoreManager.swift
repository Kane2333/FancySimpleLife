//
//  FirestoreManager.swift
//  FancyLifeDemo
//
//  Created by Laverne  on 2020/3/27.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import UIKit
import Firebase

class FirestoreManager {
    static let shared       = FirestoreManager()
    let db                  = Firestore.firestore()
    let cache               = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func getTuanGoList(for location: String, completed: @escaping (Result<[TuanGo], FLError>) -> Void) {
        let tuanGoRef = db.collection("TuanGo")
        tuanGoRef.whereField("location", isEqualTo: location).order(by: "priority").limit(to: 6).getDocuments { (snapshot, error) in
            var tuanGoList: [TuanGo] = []
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let id              = document.documentID
                    let imageURL        = document.get("imageURL")
                    let title           = document.get("title")
                    let secondaryTitle  = document.get("secondaryTitle")
                    let amount          = document.get("amount")
                    let price           = document.get("price")
                    let originalPrice   = document.get("originalPrice")
                    let tuanGoItem      = TuanGo(id: id , title: title as! String, secondaryTitle: secondaryTitle as! String, amount: amount as! Double, price: price as! Double, originalPrice: originalPrice as! Double, imageURL: imageURL as! String)
                    tuanGoList.append(tuanGoItem)
                }
                completed(.success(tuanGoList))
            } else { completed(.failure(.invalidData)) }
        }
    }
    
    
    func getAdList(for location: String, completed: @escaping (Result<[AdImage], FLError>) -> Void) {
        let adRef = db.collection("AdImage")
        adRef.whereField("location", isEqualTo: location).getDocuments { (snapshot, error) in
            var adList: [AdImage] = []
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let id          = document.documentID
                    let imageURL    = document.get("imageURL")
                    let adImageItem = AdImage(id: id , imageURL: imageURL as! String)
                    adList.append(adImageItem)
                }
                completed(.success(adList))
            } else { completed(.failure(.invalidData)) }
        }
    }
    
    
    func getShopList(kind: String?=nil, category: String?=nil, shopsToGo: Int = 0, shopID: String?=nil, completed: @escaping (Result<[Shop], FLError>) -> Void) {
        let shopRef = db.collection("Shop")
        if category == nil && kind == nil {
            shopRef.order(by: "priority").getDocuments { (snapshot, error) in
                var shopList: [Shop] = []
                if error == nil && snapshot != nil {
                    for document in snapshot!.documents {
                        let id              = document.documentID
                        let imageURL        = document.get("imageURL")
                        let title           = document.get("title")
                        let secondaryTitle  = document.get("secondaryTitle")
                        let score           = document.get("score")
                        let location        = document.get("location")
                        let openingTime     = document.get("openingTime")
                        let categoryName    = document.get("category")
                        let address         = document.get("address")
                        let kind            = document.get("kind")
                        let shopItem = Shop(id: id , imageURL: imageURL as! String, title: title as! String, secondaryTitle: secondaryTitle as! String, score: score as! Double, location: location as! [Double], openingTime: openingTime as! String, category: categoryName as! String, address: address as! String, kind: kind as! String)
                        shopList.append(shopItem)
                    }
                    completed(.success(shopList))
                } else { completed(.failure(.invalidData)) }
            }
        }
        if kind != nil {
            shopRef.whereField("kind", isEqualTo: kind!).order(by: "priority").limit(to: 7).getDocuments { (snapshot, error) in
                var shopList: [Shop] = []
                var shopCount: Int = 0
                if error == nil && snapshot != nil {
                    for document in snapshot!.documents {
                        let id          = document.documentID
                        if id != shopID {
                            let imageURL    = document.get("imageURL")
                            let title       = document.get("title")
                            let secondaryTitle  = document.get("secondaryTitle")
                            let score           = document.get("score")
                            let location        = document.get("location")
                            let openingTime     = document.get("openingTime")
                            let categoryName    = document.get("category")
                            let address         = document.get("address")
                            let kind            = document.get("kind")
                            let shopItem = Shop(id: id , imageURL: imageURL as! String, title: title as! String, secondaryTitle: secondaryTitle as! String, score: score as! Double, location: location as! [Double], openingTime: openingTime as! String, category: categoryName as! String, address: address as! String, sameCategoryShops: shopCount - 1, kind: kind as! String)
                            shopCount += 1
                            shopList.append(shopItem)
                        }
                    }
                    if shopCount < 6 {
                        FirestoreManager.shared.getShopList(category: category, shopsToGo: 6 - shopCount, shopID: shopID) { [weak self] result in
                            guard self != nil else { return }
                            switch result {
                            case .success(let shops):
                                shopList.append(contentsOf: shops)
                                completed(.success(shopList))
                            case .failure:
                                completed(.failure(.invalidData))
                            }
                        }
                    }
                } else { completed(.failure(.invalidData)) }
            }
        }
        if category != nil && kind == nil {
            shopRef.whereField("category", isEqualTo: category!).order(by: "priority").limit(to: shopsToGo + 1).getDocuments { (snapshot, error) in
                var shopList: [Shop] = []
                var shopCount: Int = 0
                if error == nil && snapshot != nil {
                    for document in snapshot!.documents {
                        let id = document.documentID
                        if id != shopID {
                            let imageURL        = document.get("imageURL")
                            let title           = document.get("title")
                            let secondaryTitle  = document.get("secondaryTitle")
                            let score           = document.get("score")
                            let location        = document.get("location")
                            let openingTime     = document.get("openingTime")
                            let categoryName    = document.get("category")
                            let address         = document.get("address")
                            let kind            = document.get("kind")
                            let shopItem = Shop(id: id , imageURL: imageURL as! String, title: title as! String, secondaryTitle: secondaryTitle as! String, score: score as! Double, location: location as! [Double], openingTime: openingTime as! String, category: categoryName as! String, address: address as! String, kind: kind as! String)
                            shopList.append(shopItem)
                            shopCount += 1
                        }
                        if shopCount == shopsToGo { break }
                    }
                    completed(.success(shopList))
                } else { completed(.failure(.invalidData)) }
            }
        }
    }
    
    
    
    func getFirstEvent(for shopID: String, completed: @escaping (Result<Event, FLError>) -> Void) {
        db.collection("Event").whereField("shopID", isEqualTo: shopID).order(by: "priority").getDocuments { (snapshot, error) in
            var count: Int = 0
            if error == nil && snapshot != nil {
                if snapshot?.documents.count == 0 {
                    completed(.failure(.incompletedInfo))
                }
                for document in snapshot!.documents {
                    let eventID             = document.documentID
                    let eventTitle          = document.get("title") as! String
                    let eventDescription    = document.get("description") as! String
                    let startTS             = document.get("startTime") as! Timestamp
                    let startDate           = startTS.dateValue()
                    let endTS               = document.get("endTime") as! Timestamp
                    let endDate             = endTS.dateValue()
                    let eventPrice          = document.get("price") as! Double
                    let eventOriginalPirce  = document.get("originalPrice") as! Double
                    let eventImageURL       = document.get("imageURL") as! String
                    let event               = Event(id: eventID, shopID: shopID, title: eventTitle, startDate: startDate, endDate: endDate, description: eventDescription, imageURL: eventImageURL, price: eventPrice, originalPrice: eventOriginalPirce)
                    count += 1
                    if count == 1 { completed(.success(event)) }
                }
            } else { completed(.failure(.invalidData)) }
        }
    }
    
    
    func getThreeProducts(for shopID: String, completed: @escaping (Result<[Product], FLError>) -> Void) {
        db.collection("Product").whereField("shopID", isEqualTo: shopID).order(by: "priority").limit(to: 3).getDocuments { (snapshot, error) in
            var productList: [Product] = []
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let id          = document.documentID
                    let imageURL    = document.get("imageURL")
                    let title       = document.get("title")
                    let description = document.get("description")
                    let price       = document.get("price")
                    let sale        = document.get("sale")
                    let product = Product(id: id, shopID: shopID, imageURL: imageURL as! String, title: title as! String, description: description as! String, price: price as! Double, sale: sale as! Double)
                    productList.append(product)
                }
                completed(.success(productList))
            } else { completed(.failure(.invalidData)) }
        }
    }
    
    
    func getFirstReview(for shopID: String, completed: @escaping (Result<Review, FLError>) -> Void) {
        db.collection("Review").whereField("shopID", isEqualTo: shopID).whereField("priority", isEqualTo: 0).getDocuments { (snapshot, error) in
            var review: Review!
            if error == nil && snapshot != nil {
                let totalReviews    = snapshot!.documents.count
                let document        = snapshot!.documents[0]
                let id              = document.documentID
                let userID          = document.get("userID") as! String
                let username        = document.get("username") as! String
                let avatarImageURL  = document.get("avatarImageURL") as! String
                let content         = document.get("content") as! String
                let likeAmount      = document.get("likeCount") as! Double
                let imageURLs       = document.get("images") as! [String]
                review = Review(id: id, shopID: shopID, username: username, avatarImageURL: avatarImageURL, imageURLs: imageURLs, content: content, likeAmount: likeAmount, userID: userID, totalReviews: totalReviews)
            } else { completed(.failure(.invalidData)) }
            completed(.success(review))
        }
    }
    
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async { completed(image) }
        }
        
        task.resume()
    }
    
}

