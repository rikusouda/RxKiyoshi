//
//  KiyoshiViewController.swift
//  RxKiyoshi
//
//  Created by Yuki Yoshioka on 2017/05/04.
//  Copyright © 2017年 Yuki Yoshioka. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class KiyoshiViewController: UIViewController {
    @IBOutlet weak var zunButton: UIBarButtonItem!
    @IBOutlet weak var dokoButton: UIBarButtonItem!
    @IBOutlet weak var outputTextView: UITextView!
    
    var viewModel = KiyoshiViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.outputString
            .bind(to: outputTextView.rx.text)
            .addDisposableTo(disposeBag)
        
        viewModel.test()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
