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
            .map { $0 + "\n" + self.outputTextView.text }
            .bind(to: outputTextView.rx.text)
            .disposed(by: disposeBag)
        
        zunButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.addZun()
            }
            .addDisposableTo(disposeBag)
        
        dokoButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.addDoko()
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
