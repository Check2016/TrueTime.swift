//
//  UserDefaultsCache.swift
//  TrueTime-iOS
//
//  Created by Marcel Egle on 25.04.19.
//  Copyright © 2019 Instacart. All rights reserved.
//

import Foundation

@objc public class UserDefaultsCache : NSObject, CacheProtocol {
    
    public func set(key: String, value: Int64) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    public func get(key: String, defaultValue: Int64) -> Int64 {
        return UserDefaults.standard.value(forKey: key) as? Int64 ?? defaultValue
    }
    
    //No flushing required for UserDefaults
    public func flush() { }
}
