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
    private var manager: TimelineManager!
    private var avatarProvider: MockAvatarProvider!

    private func setUpManager(error: Bool = false) {
        avatarProvider = MockAvatarProvider(error: error)
        manager = TimelineManager(avatarProvider: avatarProvider)
    }

    func testFirstTweetDecodedCorrectly() {
        setUpManager()
        let tweet = manager.tweets.first!
        XCTAssert(tweet.id == "00001")
        XCTAssert(tweet.author.name == "@doge")
        XCTAssert(tweet.content == "Wow, much tweet, such app!")
        XCTAssert(tweet.author.avatarURL?.absoluteString == "http://doge2048.com/meta/doge-600.png")
        XCTAssert(tweet.date == ISO8601DateFormatter().date(from: "2016-09-29T14:41:00-08:00"))
    }

    func testReplies() {
        setUpManager()
        guard let tweet00042 = manager.tweets.first(where: { $0.id == "00042" }),
              let tweet00004 = manager.tweets.first(where: { $0.id == "00004" }) else {
            return XCTFail("Cannot get tweets")
        }
        XCTAssert(tweet00004.inReplyTo == tweet00042)
        XCTAssert(tweet00042.replies.contains(tweet00004))
    }

    func testPosGetUserAvatar() {
        setUpManager()
        let image = UIImage(data: avatarProvider.data)
        manager.getUserAvatars {
            self.manager.tweets.forEach {
                XCTAssertEqual($0.author.avatar, image)
            }
        }
    }

    func testNegGetUserAvatar() {
        setUpManager(error: true)
        manager.getUserAvatars {
            self.manager.tweets.forEach {
                XCTAssertEqual($0.author.avatar, UIImage(named: "person.crop.circle"))
            }
        }
    }
}
