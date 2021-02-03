//
//  OpenTweetTests.swift
//  OpenTweetTests
//
//  Created by Olivier Larivain on 9/30/16.
//  Copyright © 2016 OpenTable, Inc. All rights reserved.
//

import XCTest
@testable import OpenTweet

class OpenTweetTests: XCTestCase {
    func testFirstTweetDecodedCorrectly() {
        let tweet = TimelineManager.shared.tweets.first!
        XCTAssert(tweet.id == "00001")
        XCTAssert(tweet.author.name == "@doge")
        XCTAssert(tweet.content == "Wow, much tweet, such app!")
        XCTAssert(tweet.author.avatarURL?.absoluteString == "http://doge2048.com/meta/doge-600.png")
        XCTAssert(tweet.date == ISO8601DateFormatter().date(from: "2016-09-29T14:41:00-08:00"))
    }

    func testReplies() {
        guard let tweet00042 = TimelineManager.shared.tweets.first(where: { $0.id == "00042" }),
              let tweet00004 = TimelineManager.shared.tweets.first(where: { $0.id == "00004" }) else {
            return XCTFail("Cannot get tweets")
        }
        XCTAssert(tweet00004.inReplyTo == tweet00042)
        XCTAssert(tweet00042.replies.contains(tweet00004))
    }
}
