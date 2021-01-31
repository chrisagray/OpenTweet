//
//  TweetDetailsTableViewCell.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/31/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TweetDetailsTableViewCell: UITableViewCell, TweetCellLayout {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
}
