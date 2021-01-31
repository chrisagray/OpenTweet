//
//  TweetTableViewCell.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/30/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!

    // TODO: The table view cell shouldn't know about Tweet
    func configureCell(with tweet: Tweet, avatar: UIImage?) {
//        authorImageView.image = UIImageView(image: UIImage()
        authorLabel.text = tweet.author
        dateLabel.text = ISO8601DateFormatter().string(from: tweet.date)
        tweetContentLabel.text = tweet.content
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.image = avatar
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
