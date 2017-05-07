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
    @IBOutlet weak var kiyoshiLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = KiyoshiViewModel()
    var disposeBag = DisposeBag()
    var isLastKiyoshi = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kiyoshiLabel.layer.masksToBounds = true
        kiyoshiLabel.layer.cornerRadius = 5
        kiyoshiLabel.alpha = 0
        
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
        
        viewModel.history.asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "KiyoshiCell",
                                         cellType: KiyoshiTableViewCell.self)) { (_, element, cell) in
                cell.kiyoshiLabel.text = element
            }
            .addDisposableTo(disposeBag)
        
        viewModel.history.asObservable()
            .map { $0.prefix(1) }
            .subscribe(onNext: { [weak self] (value) in
                if value == ["キヨシ"].prefix(1) {
                    self?.isLastKiyoshi = true
                    DispatchQueue.main.async {
                        if self?.isLastKiyoshi == true {
                            self?.kiyoshiAnimation()
                        }
                    }
                } else {
                    self?.isLastKiyoshi = false
                }
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - 

    func kiyoshiAnimation() {
        UIView.animate(withDuration: 0.75,
                       animations: { [weak self] in
                        self?.kiyoshiLabel.alpha = 1
        }) { [weak self] (_) in
            UIView.animate(withDuration: 0.75) { [weak self] in
                self?.kiyoshiLabel.alpha = 0
            }
        }
    }
}
