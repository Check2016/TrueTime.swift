//
//  CacheProtocol.swift
//  TrueTime-iOS
//
//  Created by Marcel Egle on 24.04.19.
//  Copyright © 2019 Instacart. All rights reserved.
//

import Foundation

@objc public protocol CacheProtocol {
    
    func set(key: String, value: Int64)
    
    func get(key: String) -> Int64?
    
    func flush()
}
