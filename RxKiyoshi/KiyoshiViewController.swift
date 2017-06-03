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

class KiyoshiViewController: UITableViewController {
    @IBOutlet weak var zunButton: UIBarButtonItem!
    @IBOutlet weak var dokoButton: UIBarButtonItem!
    
    var viewModel = KiyoshiViewModel()
    var disposeBag = DisposeBag()
    
    var kiyoshiToast: ProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = nil
        viewModel.history.asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "KiyoshiCell",
                                              cellType: KiyoshiTableViewCell.self)) { (_, element, cell) in
                                                cell.kiyoshiLabel.text = element
            }
            .addDisposableTo(disposeBag)
        
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
        
        self.kiyoshiToast = ProgressHUD.createTextToast(to: self.view, text: "キヨシ!")
        viewModel.history.asObservable()
            .map { $0.prefix(1) }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (value) in
                guard let this = self else { return }
                if value == ["キヨシ"].prefix(1) {
                    this.kiyoshiToast?.show(animated: true)
                    this.kiyoshiToast?.hide(animated: true, afterDelay: 1.0)
                }
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
