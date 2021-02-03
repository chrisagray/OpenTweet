//
//  TweetData.swift
//  OpenTweet
//
//  Created by Chris Gray on 2/2/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import Foundation

struct TweetData: Codable, Equatable {
    let id: String
    let author: String
    let content: String
    let date: Date
    var avatar: URL?
    let inReplyTo: String?
    let imageURLs: [URL]?
}
