//
//  TweetCellLayout.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/31/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

protocol TweetCellLayout: UITableViewCell {
    var avatarImageView: UIImageView! { get set }
    var authorLabel: UILabel! { get set }
    var dateLabel: UILabel! { get set }
    var tweetContentLabel: UILabel! { get set }
}

extension TweetCellLayout {
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
