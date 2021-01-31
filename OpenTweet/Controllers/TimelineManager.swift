//
//  TimelineManager.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/30/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineManager {
    // MARK: Properties

    static let shared = TimelineManager()

    let avatarProvider = AvatarProvider()
    private(set) var userTimeline = UserTimeline(timeline: [])
    // TODO: Need both dictionary and set?
    private(set) var userAvatars: [String: UIImage]  = [:]
    private(set) var users: Set<String> = []

    // MARK: Methods

    // TODO: This method is doing a lot
    func getUserAvatars(completion: @escaping (() -> Void)) {
        let group = DispatchGroup()
        userTimeline.timeline.forEach { tweet in
            users.insert(tweet.author)
            group.enter()
            if let avatarURL = tweet.avatar, userAvatars[tweet.author] == nil {
                avatarProvider.getUserAvatar(url: avatarURL) { [weak self] result in
                    switch result {
                    case .success(let data):
                        self?.userAvatars[tweet.author] = UIImage(data: data)

                    case .failure(let error):
                        print(error)
                    }
                    group.leave()
                }
            } else {
                group.leave()
            }
        }

        group.wait()
        DispatchQueue.main.async {
            completion()
        }
    }

    func mentions(in tweet: Tweet) -> [String] {
        tweet.content.components(separatedBy: " ")
            .filter { $0.hasPrefix("@") }
            .filter { users.contains($0) }
    }

    func decodeTimeline() {
        do {
            guard let timelineData = getTimelineData() else {
                //            throw NSError(domain: "", code: -1, userInfo: [:])
                return print("Cannot get timeline data")
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            userTimeline = try decoder.decode(UserTimeline.self, from: timelineData)
        } catch {
            print(error)
        }
    }

    private func getTimelineData() -> Data? {
        guard let path = Bundle.main.path(forResource: "timeline", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            return nil
        }
        return data
    }

}
