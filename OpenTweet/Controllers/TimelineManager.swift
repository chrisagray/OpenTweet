//
//  TimelineManager.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/30/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

final class TimelineManager {
    // MARK: Properties

    static let shared = TimelineManager()
    private(set) var tweets: [Tweet] = []

    // MARK: Private properties

    // TODO: Need all these properties?
    private let avatarProvider = AvatarProvider()
    private var timelineData = TimelineData(timeline: [])
    private var tweetIdsAndTweets: [String: Tweet] = [:]
    private var authorIdsAndAuthors: [String: Author] = [:]
    private var authorIds: Set<String> = []
    private var authors: Set<Author> = []

    private init() {
        timelineData = decodeTimeline()
        setRelationships()
        setTweetMentions()
    }

    // MARK: Methods

    func getUserAvatars(completion: @escaping (() -> Void)) {
        guard !authors.isEmpty else {
            return
        }
        let group = DispatchGroup()
        authors.forEach { author in
            if let avatarURL = author.avatarURL {
                getAvatar(at: avatarURL, for: author, group: group)
            }
        }
        group.wait()
        DispatchQueue.main.async {
            completion()
        }
    }

    // MARK: Private methods

    private func getAvatar(at url: URL, for author: Author, group: DispatchGroup) {
        group.enter()
        avatarProvider.getUserAvatar(url: url) { result in
            switch result {
            case .success(let image):
                author.avatar = image

            case .failure(let error):
                print(error)
            }
            group.leave()
        }
    }

    private func decodeTimeline() -> TimelineData {
        let emptyTimeline = TimelineData(timeline: [])
        guard let path = Bundle.main.path(forResource: "timeline", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            return emptyTimeline
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return (try? decoder.decode(TimelineData.self, from: data)) ?? emptyTimeline
    }

    private func setRelationships() {
        timelineData.timeline.forEach { tweetData in
            let author = getAuthor(data: tweetData)
            let tweet = createTweet(with: tweetData, author: author)
            author.tweets.append(tweet)
        }
    }

    private func getAuthor(data: TweetData) -> Author {
        guard let author = authorIdsAndAuthors[data.author] else {
            let newAuthor = Author(name: data.author, tweets: [], avatarURL: data.avatar)
            authors.insert(newAuthor)
            authorIds.insert(newAuthor.name)
            authorIdsAndAuthors[newAuthor.name] = newAuthor
            return newAuthor
        }
        return author
    }

    private func createTweet(with data: TweetData, author: Author) -> Tweet {
        var inReplyToTweet: Tweet?
        if let inReplyToId = data.inReplyTo {
            inReplyToTweet = tweetIdsAndTweets[inReplyToId]
        }
        let tweet = Tweet(
            id: data.id,
            content: data.content,
            date: data.date,
            author: author,
            inReplyTo: inReplyToTweet,
            replies: [],
            mentions: [],
            urls: []
        )
        inReplyToTweet?.replies.append(tweet)
        tweetIdsAndTweets[data.id] = tweet
        tweets.append(tweet)

        return tweet
    }

    private func setTweetMentions() {
        tweets.forEach { tweet in
            let mentions = tweet.content.components(separatedBy: " ").filter { authorIds.contains($0) }
            tweet.mentions = mentions.compactMap { authorIdsAndAuthors[$0] }
        }
    }
}
