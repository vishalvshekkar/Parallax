//
//  File.swift
//  iTunesCoverColor
//
//  Created by Vishal on 9/29/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import Foundation

extension NSCache {
    subscript(key: AnyObject) -> AnyObject? {
        get {
            return objectForKey(key)
        }
        set {
            if let value: AnyObject = newValue {
                setObject(value, forKey: key)
            } else {
                removeObjectForKey(key)
            }
        }
    }
}