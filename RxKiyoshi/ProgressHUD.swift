//
//  HUDUtil.swift
//  RxKiyoshi
//
//  Created by Yuki Yoshioka on 2017/06/03.
//  Copyright © 2017年 Yuki Yoshioka. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD

struct ProgressHUD {
    static func createTextToast(to view: UIView, text: String) -> ProgressHUD {
        let mbHud = MBProgressHUD(view: view)
        mbHud.label.text = text
        mbHud.mode = .customView
        mbHud.bezelView.style = .blur
        mbHud.isUserInteractionEnabled = false
        
        view.addSubview(mbHud)
        
        return ProgressHUD(hud: mbHud)
    }
    
    let hud: MBProgressHUD
    
    init(hud: MBProgressHUD) {
        self.hud = hud
    }
    
    func show(animated: Bool) {
        self.hud.show(animated: animated)
    }
    
    func hide(animated: Bool, afterDelay: TimeInterval) {
        self.hud.hide(animated: animated, afterDelay: afterDelay)
    }
}
