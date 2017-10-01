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

protocol ZunDokoViewModel {
    var name: String { get }
}

// Use Model as ViewModel without transform
extension ZunDoko: ZunDokoViewModel {
    var name: String {
        return self.toString()
    }
}

class KiyoshiViewModel {
    var history = Variable<[ZunDokoViewModel]>([])
    
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
        
        history.value.insert(newObject, at: 0)
        
        let realm = try! Realm()
        try! realm.write() {
            realm.add(newObject)
        }
        
        let expected: [String] = ["ドコ", "ズン", "ズン", "ズン", "ズン"]
        for (index, value) in history.value.prefix(5).enumerated() {
            if value.name != expected[index] { return }
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5, execute: { [weak self] in
            self?.add(next: .kiyoshi)
        })
    }
    
    func reloadData() {
        let realm = try! Realm()
        let zdks = realm.objects(ZunDoko.self).sorted(byKeyPath: "id", ascending: false)
        history.value = Array(zdks)
    }
    
}
