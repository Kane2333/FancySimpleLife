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
                    let id              = document.get("id")
                    let imageURL        = document.get("imageURL")
                    let title           = document.get("title")
                    let secondaryTitle  = document.get("secondaryTitle")
                    let amount          = document.get("amount")
                    let price           = document.get("price")
                    let originalPrice   = document.get("originalPrice")
                    let tuanGoItem      = TuanGo(id: id as! String, title: title as! String, secondaryTitle: secondaryTitle as! String, amount: amount as! Double, price: price as! Double, originalPrice: originalPrice as! Double, imageURL: imageURL as! String)
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
                    let id          = document.get("id")
                    let imageURL    = document.get("imageURL")
                    let adImageItem = AdImage(id: id as! String, imageURL: imageURL as! String)
                    adList.append(adImageItem)
                }
                completed(.success(adList))
            } else { completed(.failure(.invalidData)) }
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

