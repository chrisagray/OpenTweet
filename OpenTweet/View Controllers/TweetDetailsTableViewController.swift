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

    private lazy var tweets: [Tweet] = {
        var tweets: [Tweet] = [tweet.inReplyTo, tweet].compactMap { $0 }
        tweets.append(contentsOf: tweet.replies)
        return tweets
    }()

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    func getTweetCell(for tweet: Tweet) -> TweetCellLayout.Type {
        switch tweet {
        case self.tweet:
            return TweetDetailsTableViewCell.self

        default:
            return TweetTableViewCell.self
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tweet = tweets[indexPath.row]
        return getTweetTableViewCell(for: tweet, type: getTweetCell(for: tweet))
    }

    func getTweetTableViewCell<T: UITableViewCell>(for tweet: Tweet, type: T.Type) -> UITableViewCell {
        guard let tweetCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: type)
        ) as? TweetCellLayout else {
            return UITableViewCell()
        }
        tweetCell.configureCell(with: tweet)
        return tweetCell
    }

}
