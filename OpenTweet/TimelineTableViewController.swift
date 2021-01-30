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

    private var userTimeline = UserTimeline(timeline: [])

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let timeline = TimelineDecoder().decodeTimeline() {
            userTimeline = timeline
        }
        print(userTimeline.timeline)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userTimeline.timeline.count
    }

}
