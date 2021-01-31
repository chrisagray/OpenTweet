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

    private let avatarProvider = AvatarProvider()
    private let timelineManager = TimelineManager.shared

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        timelineManager.getUserAvatars { [weak self] in
            self?.tableView.reloadData()
        }
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timelineManager.userTimeline.timeline.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TweetTableViewCell.self)
        ) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        let tweet = timelineManager.userTimeline.timeline[indexPath.row]
        let avatar = timelineManager.userAvatars[tweet.author]
        let mentions = timelineManager.mentions(in: tweet)
        cell.configureCell(with: tweet, avatar: avatar, mentions: mentions)

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tweetDetailsTableVC = segue.destination as? TweetDetailsTableViewController,
              let indexPath = tableView.indexPathForSelectedRow else {
            return
        }

        let selectedTweet = timelineManager.userTimeline.timeline[indexPath.row]
        tweetDetailsTableVC.tweet = selectedTweet
        tweetDetailsTableVC.replies = timelineManager.replies(to: selectedTweet)
        tweetDetailsTableVC.inReplyTo = timelineManager.previousTweet(to: selectedTweet)
    }

}
