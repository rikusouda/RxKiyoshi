//
//  KiyoshiViewModel.swift
//  RxKiyoshi
//
//  Created by Yuki Yoshioka on 2017/05/04.
//  Copyright © 2017年 Yuki Yoshioka. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


class KiyoshiViewModel {
    enum ZunDoko2: Int {
        case ズン
        case ドコ
        case キヨシ
    }
    
    var history: [ZunDoko2] = [.ドコ, .ドコ, .ドコ, .ドコ, .ドコ]
    let outputString = PublishSubject<String>()
    
    init() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
    
    func addZun() {
        add(next: .ズン)
    }
    
    func addDoko() {
        add(next: .ドコ)
        
        let realm = try! Realm()
        try! realm.write() {
            let newObject = ZunDoko.create(val: ZunDoko.Zdk.zun)
            realm.add(newObject)
        }
    }
    
    private func add(next: ZunDoko2) {
        history = history[1...4] + [next]
        outputString.onNext("\(next)")
        
        let realm = try! Realm()
        try! realm.write() {
            if let zdk = ZunDoko.Zdk(rawValue: next.rawValue) {
                let newObject = ZunDoko.create(val: zdk)
                realm.add(newObject)
            }
        }
        
        if history == [.ズン, .ズン, .ズン, .ズン, .ドコ] {
            add(next: .キヨシ)
        }
    }
    
    func reloadData() {
        history = [.ドコ, .ドコ, .ドコ, .ドコ, .ドコ]
        
        let realm = try! Realm()
        let zdks = realm.objects(ZunDoko.self).sorted(byKeyPath: "id")
        
        for zdk in zdks {
            let zdk2 = ZunDoko2(rawValue: zdk.valAsZdk.rawValue)!
            history = history[1...4] + [zdk2]
            outputString.onNext("\(zdk2)")
        }
    }
    
}
