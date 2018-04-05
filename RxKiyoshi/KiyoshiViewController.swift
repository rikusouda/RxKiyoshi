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
import AVFoundation

class KiyoshiViewController: UITableViewController {
    @IBOutlet weak var zunButton: UIBarButtonItem!
    @IBOutlet weak var dokoButton: UIBarButtonItem!
    
    var viewModel = KiyoshiViewModel()
    var disposeBag = DisposeBag()
    
    var kiyoshiToast: ProgressHUD?
    private var talker = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = nil
        viewModel.history
            .asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "KiyoshiCell",
                                              cellType: KiyoshiTableViewCell.self)) { (_, element, cell) in
                                                cell.kiyoshiLabel.text = element.name
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
        
        tableView.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak self] (indexPath) in
                if let item = self?.viewModel.history.value[indexPath.row] {
                    self?.speak(text: item.name)
                }
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
        self.kiyoshiToast = ProgressHUD.createTextToast(to: self.view, text: "キヨシ!")
        viewModel.history.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (value) in
                guard let this = self else { return }
                if let first = value.first {
                    if first.name == "キヨシ" {
                        this.kiyoshiToast?.show(animated: true)
                        this.kiyoshiToast?.hide(animated: true, afterDelay: 1.0)
                    }
                    
                    this.speak(text: first.name)
                    
                    DispatchQueue.main.async {
                        this.tableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                                   at: .top, animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        self.talker.speak(utterance)
    }
}
