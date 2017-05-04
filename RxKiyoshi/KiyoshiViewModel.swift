//
//  KiyoshiViewModel.swift
//  RxKiyoshi
//
//  Created by Yuki Yoshioka on 2017/05/04.
//  Copyright © 2017年 Yuki Yoshioka. All rights reserved.
//

import Foundation
import RxSwift

struct KiyoshiViewModel {
    
    let outputString = PublishSubject<String>()
    
    func test() {
        outputString.onNext("ここでズンドコする")
    }
    
}
