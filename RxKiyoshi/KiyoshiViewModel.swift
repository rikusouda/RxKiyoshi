//
//  KiyoshiViewModel.swift
//  RxKiyoshi
//
//  Created by Yuki Yoshioka on 2017/05/04.
//  Copyright © 2017年 Yuki Yoshioka. All rights reserved.
//

import Foundation
import RxSwift


class KiyoshiViewModel {
    enum ZunDoko {
        case ズン
        case ドコ
        case キヨシ
    }
    
    var history: [ZunDoko] = [.ドコ, .ドコ, .ドコ, .ドコ, .ドコ]
    let outputString = PublishSubject<String>()
    
    func addZun() {
        add(next: .ズン)
    }
    
    func addDoko() {
        add(next: .ドコ)
    }
    
    private func add(next: ZunDoko) {
        history = history[1...4] + [next]
        outputString.onNext("\(next)")
        
        if history == [.ズン, .ズン, .ズン, .ズン, .ドコ] {
            add(next: .キヨシ)
        }
    }
    
}
