//
//  DiskCacheClient.swift
//  TrueTime-iOS
//
//  Created by Marcel Egle on 24.04.19.
//  Copyright © 2019 Instacart. All rights reserved.
//

import Foundation

public class DiskCacheClient : NSObject {
    
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
            
            let currentFirstTime = cache.get(key: DiskCacheClient.keyCachedFirstTime)
            
            if currentFirstTime == nil {
                
                cache.set(key: DiskCacheClient.keyCachedFirstTime, value: referenceTime.time.toMilliseconds())
            }
            
            cache.flush()
        }
    }
    
    func isCacheValid() -> Bool {
        
        if let cache : CacheProtocol = cacheProtocol {
            
            let cachedBootTime = cache.get(key: DiskCacheClient.keyCachedBootTime) ?? Int64(0)
            
            if cachedBootTime > 0 && cachedBootTime == timeval.boottime().milliseconds {
                
                return true
            }
        }
        
        return false
    }

    func getCachedReferenceTime() -> ReferenceTime? {
        
        if let cache : CacheProtocol = cacheProtocol {
            
            if let time : Int64 = cache.get(key: DiskCacheClient.keyCachedTime),
                let uptime : Int64 = cache.get(key: DiskCacheClient.keyCachedUptime) {
                
                return ReferenceTime(time: Date.fromMilliseconds(milliseconds: time),
                                     uptime: timeval.fromMilliseconds(milliseconds: uptime))
            }
        }
        
        return nil
    }
}
