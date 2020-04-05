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
        
    
    func getShopList(completed: @escaping (Result<[Shop], FLError>) -> Void) {
        let shopRef = db.collection("Shop")
        //let order = byRating ? "score" : "priority"
        //if category != nil {
        shopRef.order(by: "priority").getDocuments { (snapshot, error) in
            var shopList: [Shop] = []
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let id          = document.documentID
                    let imageURL    = document.get("imageURL")
                    let title       = document.get("title")
                    let secondaryTitle  = document.get("secondaryTitle")
                    let score           = document.get("score")
                    let location        = document.get("location")
                    let openingTime     = document.get("openingTime")
                    let categoryName        = document.get("category")
                    let shopItem = Shop(id: id , imageURL: imageURL as! String, title: title as! String, secondaryTitle: secondaryTitle as! String, score: score as! Double, location: location as! [Double], openingTime: openingTime as! String, category: categoryName as! String)
                    shopList.append(shopItem)
                }
                completed(.success(shopList))
            } else { completed(.failure(.invalidData)) }
        }
    }
    
    
    func getFirstEvent(for shopID: String, completed: @escaping (Result<Event, FLError>) -> Void) {
        db.collection("Event").whereField("shopID", isEqualTo: shopID).whereField("priority", isEqualTo: 0).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                let document            = snapshot!.documents[0]
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
                let event               = Event(id: eventID, shopID: shopID, title: eventTitle, startDate: startDate, endDate: endDate, description: eventDescription, imageUrl: eventImageURL, price: eventPrice, originalPrice: eventOriginalPirce)
                completed(.success(event))
            } else { completed(.failure(.invalidData)) }
        }
    }
    
    
    func getShopInfo(for shopID: String, shopTitle: String, shopAddress: String, shopOpenningTime: String, shopImageURL: String, shopCategory: String, completed: @escaping (Result<[ShopInfo], FLError>) -> Void) {
        var eventID: String!
        var eventTitle: String!
        var eventDescription: String!
        var eventStartDate: Date!
        var eventEndDate: Date!
        var eventPrice: Double!
        var eventOriginalPirce: Double!
        var eventImageURL: String!
        var productImageURLs: [String] = []
        var reviewUsername: String?
        var reviewAvatarImageURL: String?
        var reviewContent: String?
        var reviewImageURLs: [String] = []
        var reviewAmount: Int!
        var reviewLikeAmount: Double?
        var recommendShopIDs: [String] = []
        var recommendShopTitles: [String] = []
        var recommendShopImages: [String] = []
        var recommendShopScores: [Double] = []
        
        db.collection("Event").whereField("shopID", isEqualTo: shopID).whereField("priority", isEqualTo: 0).getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                let document = snapshot!.documents[0]
                eventID = document.documentID
                eventTitle  = (document.get("title") as! String)
                eventDescription    = (document.get("description") as! String)
                let startTS         = document.get("startTime") as! Timestamp
                eventStartDate      = startTS.dateValue()
                let endTS           = document.get("endTime") as! Timestamp
                eventEndDate        = endTS.dateValue()
                eventPrice          = (document.get("price") as! Double)
                eventOriginalPirce  = (document.get("originalPrice") as! Double)
                eventImageURL       = (document.get("imageURL") as! String)
            } else { completed(.failure(.invalidData)) }
        }
        
        db.collection("Product").whereField("shopID", isEqualTo: shopID).order(by: "priority").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                var count: Int = 0
                for document in snapshot!.documents {
                    if count < 3 {
                        productImageURLs.append(document.get("imageURL") as! String)
                        count += 1
                    } else { break }
                }
            } else { completed(.failure(.invalidData)) }
        }
        
        db.collection("Review").whereField("shopID", isEqualTo: shopID).whereField("priority", isEqualTo: 0).getDocuments { (snapshot, error) in
            
            if error == nil && snapshot != nil {
                reviewAmount    = snapshot!.documents.count
                let document    = snapshot!.documents[0]
                let reviewUID   = document.get("userID") as! String
                self.db.collection("users").document(reviewUID).getDocument { (document, error) in
                    if let document = document, document.exists {
                        reviewUsername          = document.get("username") as? String
                        reviewAvatarImageURL    = (document.get("avatarImageURL") as! String)
                    } else { completed(.failure(.invalidData)) }
                }
                reviewContent       = (document.get("content") as! String)
                reviewLikeAmount    = (document.get("likeCount") as! Double)
                reviewImageURLs     = document.get("images") as! [String]
                
            }
            if error == nil && snapshot == nil {
                reviewImageURLs         = []
                reviewAvatarImageURL    = nil
                reviewLikeAmount        = nil
                reviewContent           = nil
                reviewUsername          = nil
            } else { completed(.failure(.invalidData)) }
        }
        
        db.collection("Shop").whereField("category", isEqualTo: shopCategory).order(by: "priority").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                var count: Int = 0
                for document in snapshot!.documents {
                    if count < 6 {
                        recommendShopIDs.append(document.documentID)
                        recommendShopImages.append(document.get("imageURL") as! String)
                        recommendShopTitles.append(document.get("title") as! String)
                        recommendShopScores.append(document.get("score") as! Double)
                        count += 1
                    } else { break }
                }
            } else { completed(.failure(.invalidData)) }
        }
        let shopInfo = ShopInfo(shopID: shopID, shopImageURL: shopImageURL, shopTitle: shopTitle, shopAddress: shopAddress, shopOpeningTime: shopOpenningTime, eventID: eventID!, eventTitle: eventTitle!, eventDescription: eventDescription!, eventStartDate: eventStartDate!, eventEndDate: eventEndDate!, eventPrice: eventPrice!, eventOriginalPirce: eventOriginalPirce!, eventImageURL: eventImageURL!, productImageURLs: productImageURLs, reviewUsername: reviewUsername!, reviewAvatarImageURL: reviewAvatarImageURL!, reviewContent: reviewContent!, reviewImageURLs: reviewImageURLs, reviewAmount: reviewAmount!, reviewLikeAmount: reviewLikeAmount!, recommendShopIDs: recommendShopIDs, recommendShopTitles: recommendShopTitles, recommendShopImages: recommendShopImages, recommendShopScores: recommendShopScores)
        var shopInfoList: [ShopInfo] = []
        for _ in [0,4] {
            shopInfoList.append(shopInfo)
        }
        completed(.success(shopInfoList))
        
        
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

