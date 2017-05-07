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
    var history = Variable<[String]>([])
    
    init() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
    
    func addZun() {
        add(next: .zun)
    }
    
    func addDoko() {
        add(next: .doko)
    }
    
    private func add(next: ZunDoko.Zdk) {
        guard let zdk = ZunDoko.Zdk(rawValue: next.rawValue) else {
            return
        }
        let newObject = ZunDoko.create(val: zdk)
        
        history.value.insert(newObject.toString(), at: 0)
        
        let realm = try! Realm()
        try! realm.write() {
            realm.add(newObject)
        }
        
        let expected: [String] = ["ドコ", "ズン", "ズン", "ズン", "ズン"]
        if history.value.prefix(5) == expected.prefix(5) {
            add(next: .kiyoshi)
        }
    }
    
    func reloadData() {
        let realm = try! Realm()
        let zdks = realm.objects(ZunDoko.self).sorted(byKeyPath: "id", ascending: false)
        history.value = zdks.map { $0.toString() }
    }
    
}
