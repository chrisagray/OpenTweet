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
    func configureCell(with tweet: Tweet) {
        authorLabel.text = tweet.author.name
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        dateLabel.text = formatter.string(from: tweet.date)
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        if let avatar = tweet.author.avatar {
            avatarImageView.image = avatar
        }
        highlightMentions(in: tweet)
    }

    private func highlightMentions(in tweet: Tweet) {
        let contentAttributedString = NSMutableAttributedString(string: tweet.content)
        tweet.mentions.forEach { author in
            guard tweet.content.range(of: author.name) != nil else {
                return
            }
            let range = (tweet.content as NSString).range(of: author.name)
            contentAttributedString.setAttributes([.foregroundColor: UIColor.link], range: range)
        }
        tweetContentLabel.attributedText = contentAttributedString
    }
}
