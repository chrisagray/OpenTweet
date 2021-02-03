//
//  Author.swift
//  OpenTweet
//
//  Created by Chris Gray on 2/2/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

final class Author {
    let name: String
    var tweets: [Tweet]
    var avatarURL: URL?
    var avatar: UIImage?

    init(name: String, tweets: [Tweet], avatarURL: URL?, avatar: UIImage? = nil) {
        self.name = name
        self.tweets = tweets
        self.avatarURL = avatarURL
        self.avatar = avatar
    }
}

extension Author: Hashable {
    static func == (lhs: Author, rhs: Author) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
