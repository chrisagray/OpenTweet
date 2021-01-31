//
//  TweetDetailsTableViewController.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/31/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TweetDetailsTableViewController: UITableViewController {
    // MARK: Properties
    
    var tweet: Tweet!
    var replies: [Tweet]?
    var inReplyTo: Tweet?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var total = 1
        if inReplyTo != nil {
            total += 1
        }
        return total + (replies?.count ?? 0)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, let inReplyTo = inReplyTo {
            return getTweetTableViewCell(for: inReplyTo, type: TweetTableViewCell.self)
        } else if indexPath.row != 1, let replies = replies {
            return getTweetTableViewCell(for: replies[indexPath.row], type: TweetTableViewCell.self)
        } else {
            return getTweetTableViewCell(for: tweet, type: TweetDetailsTableViewCell.self)
        }
    }

    func getTweetTableViewCell<T: UITableViewCell>(for tweet: Tweet, type: T.Type) -> UITableViewCell {
        guard let tweetCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: T.self)
        ) as? TweetCellLayout else {
            return UITableViewCell()
        }
        tweetCell.configureCell(
            with: tweet,
            avatar: TimelineManager.shared.userAvatars[tweet.author],
            mentions: TimelineManager.shared.mentions(in: tweet)
        )
        return tweetCell
    }

}
