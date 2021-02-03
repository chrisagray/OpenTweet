//
//  TimelineTableViewController.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/30/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {
    // MARK: Properties

    private let timelineManager = TimelineManager.shared

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        timelineManager.getUserAvatars { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timelineManager.tweets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TweetTableViewCell.self)
        ) as? TweetTableViewCell else {
            return UITableViewCell()
        }

        let tweet = timelineManager.tweets[indexPath.row]
        cell.configureCell(with: tweet)

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tweetDetailsTableVC = segue.destination as? TweetDetailsTableViewController,
              let indexPath = tableView.indexPathForSelectedRow,
              timelineManager.tweets.indices.contains(indexPath.row) else {
            return
        }

        tweetDetailsTableVC.tweet = timelineManager.tweets[indexPath.row]
    }
}
