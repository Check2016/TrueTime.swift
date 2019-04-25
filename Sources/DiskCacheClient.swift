//
//  DiskCacheClient.swift
//  TrueTime-iOS
//
//  Created by Marcel Egle on 24.04.19.
//  Copyright © 2019 Instacart. All rights reserved.
//

import Foundation

@objc public class DiskCacheClient : NSObject {
    
    static let keyCachedTime = "cachedTime"
    static let keyCachedUptime = "cachedUptime"
    static let keyCachedBootTime = "cachedBootTime"
    static let keyCachedFirstTime = "cachedFirstTime"
    
    private var cacheProtocol : CacheProtocol? = nil
    
    func enableCacheProtocol(_ cacheProtocol : CacheProtocol){
        
        self.cacheProtocol = cacheProtocol
    }
    
    func cacheReferenceTime(_ referenceTime : ReferenceTime){
        
        if let cache : CacheProtocol = cacheProtocol {
            
            cache.set(key: DiskCacheClient.keyCachedTime, value: referenceTime.time.toMilliseconds())
            cache.set(key: DiskCacheClient.keyCachedUptime, value: referenceTime.uptime.milliseconds)
            cache.set(key: DiskCacheClient.keyCachedBootTime, value: timeval.boottime().milliseconds)
            
            let currentFirstTime = cache.get(key: DiskCacheClient.keyCachedFirstTime, defaultValue: Int64(0))
            
            if currentFirstTime == Int64(0) {
                
                cache.set(key: DiskCacheClient.keyCachedFirstTime, value: referenceTime.time.toMilliseconds())
            }
            
            cache.flush()
        }
    }
    
    //Does the cached boottime match the current boottime
    func isCachedReferenceTimeValid() -> Bool {
        
        if let cache : CacheProtocol = cacheProtocol {
            
            let cachedBootTime = cache.get(key: DiskCacheClient.keyCachedBootTime, defaultValue: Int64(0))
            
            if cachedBootTime > Int64(0) && cachedBootTime == timeval.boottime().milliseconds {
                
                return true
            }
        }
        
        return false
    }

    func getCachedReferenceTime() -> ReferenceTime? {
        
        if isCachedReferenceTimeValid() == false {
            return nil
        }
        
        if let cache : CacheProtocol = cacheProtocol {
            
            let time = cache.get(key: DiskCacheClient.keyCachedTime, defaultValue: Int64(0))
            let uptime = cache.get(key: DiskCacheClient.keyCachedUptime, defaultValue: Int64(0))
            
            if time > Int64(0) && uptime > Int64(0) {
                return ReferenceTime(time: Date.fromMilliseconds(milliseconds: time),
                                     uptime: timeval.fromMilliseconds(milliseconds: uptime))
            }
        }
        
        return nil
    }
    
    //The first time that was cached (As long as a non nil value is returned,
    //this time will always be valid since it's just a timestamp)
    //Useful for example for games where you want to start the regeneration of lives
    //as soon as you got a valid reference time
    func getCachedFirstTime() -> Date? {
        
        if let cache : CacheProtocol = cacheProtocol {
            
            let cachedFirstTime = cache.get(key: DiskCacheClient.keyCachedFirstTime, defaultValue: Int64(0))
            
            if cachedFirstTime > Int64(0) {
                return Date.fromMilliseconds(milliseconds: cachedFirstTime)
            }
        }
        
        return nil
    }
}
