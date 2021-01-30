//
//  ViewController.swift
//  OpenTweet
//
//  Created by Olivier Larivain on 9/30/16.
//  Copyright © 2016 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    private var userTimeline = UserTimeline(timeline: [])

	override func viewDidLoad() {
		super.viewDidLoad()
        if let timeline = TimelineDecoder().decodeTimeline() {
            userTimeline = timeline
        }
        print(userTimeline.timeline)
	}
}

