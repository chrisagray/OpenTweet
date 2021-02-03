//
//  Tweet.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/30/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

final class Tweet {
    let id: String
    let content: String
    let date: Date
    unowned let author: Author
    let inReplyTo: Tweet?
    var replies: [Tweet]
    var mentions: [Author]
    let urls: [URL]

    init(
        id: String,
        content: String,
        date: Date,
        author: Author,
        inReplyTo: Tweet?,
        replies: [Tweet],
        mentions: [Author],
        urls: [URL]
    ) {
        self.id = id
        self.content = content
        self.date = date
        self.author = author
        self.inReplyTo = inReplyTo
        self.replies = replies
        self.mentions = mentions
        self.urls = urls
    }
}

extension Tweet: Hashable {
    static func == (lhs: Tweet, rhs: Tweet) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
