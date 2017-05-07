//
//  KiyoshiTableViewCell.swift
//  RxKiyoshi
//
//  Created by Yuki Yoshioka on 2017/05/07.
//  Copyright © 2017年 Yuki Yoshioka. All rights reserved.
//

import UIKit

class KiyoshiTableViewCell: UITableViewCell {
    @IBOutlet weak var kiyoshiLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
