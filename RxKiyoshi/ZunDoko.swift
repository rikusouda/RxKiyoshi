//
//  ZunDoko.swift
//  RxKiyoshi
//
//  Created by Yuki Yoshioka on 2017/05/07.
//  Copyright © 2017年 Yuki Yoshioka. All rights reserved.
//

import Foundation
import RealmSwift

class ZunDoko: Object {
    public enum Zdk: Int {
        case zun = 0
        case doko = 1
        case kiyoshi = 2
    }
    
    dynamic var id: Int = 0
    dynamic var val: Int = 0
    
    var valAsZdk: Zdk {
        return Zdk(rawValue: self.val)!
    }
    
    static func create(val: Zdk) -> ZunDoko {
        let z = ZunDoko()
        
        do {
            let defaults = UserDefaults.standard
            let currentId = defaults.integer(forKey: "ZunDokoId")
            let newId = currentId + 1
            z.id = newId
            defaults.set(newId, forKey: "ZunDokoId")
        }
        
        z.val = val.rawValue
        return z
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toString() -> String {
        switch self.valAsZdk {
        case .zun: return "ズン"
        case .doko: return "ドコ"
        case .kiyoshi: return "キヨシ"
        }
    }
}
