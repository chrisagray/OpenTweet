//
//  TweetTableViewCell.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/30/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var tweetContentLabel: UILabel!

    func configureCell(with tweet: Tweet, avatar: UIImage?, mentions: [String]) {
        authorLabel.text = tweet.author
        dateLabel.text = ISO8601DateFormatter().string(from: tweet.date)
        let contentAttributedString = NSMutableAttributedString(string: tweet.content)
        mentions.forEach {
            guard tweet.content.range(of: $0) != nil else {
                return
            }
            let range = (tweet.content as NSString).range(of: $0)
            contentAttributedString.setAttributes([.foregroundColor: UIColor.link], range: range)
        }

        tweetContentLabel.attributedText = contentAttributedString
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        if avatar != nil {
            avatarImageView.image = avatar
        }
    }
}
