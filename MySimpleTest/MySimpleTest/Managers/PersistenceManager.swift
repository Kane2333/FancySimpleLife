//
//  PersistenceManager.swift
//  MySimpleTest
//
//  Created by Laverne  on 2020/4/11.
//  Copyright © 2020 FancyLife. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let searchHistory = "searchHistory" }
    
    static func updateWith(history: String?="", actionType: PersistenceActionType, completed: @escaping (Error?) -> Void) {
        retrieveHistories { result in
            switch result {
            case .success(var histories):
                
                switch actionType {
                case .add:
                    guard !histories.contains(history!) else { return }
                    
                    histories.insert(history!, at: 0)
                    
                case .remove:
                    histories.removeAll() // removeall where
                }
                
                completed(saveHistories(histories: histories))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveHistories(completed: @escaping (Result<[String], Error>) -> Void) {
        guard let historiesData = defaults.object(forKey: Keys.searchHistory) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
               let decoder = JSONDecoder()
               let histories = try decoder.decode([String].self, from: historiesData)
               completed(.success(histories))
        } catch {
                //completed(nil, error.localizedDescription)
            completed(.failure(error))
            print("**Error: cannot retrive search history")
        }
    }
    
    
    static func saveHistories(histories: [String]) -> Error? {
        do {
            let encoder = JSONEncoder()
            let encodedhistories = try encoder.encode(histories)
            defaults.set(encodedhistories, forKey: Keys.searchHistory)
            return nil
        } catch {
            print("**Error: Cannot save search history")
            return nil
        }
    }
}

