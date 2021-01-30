//
//  TimelineDecoder.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/30/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import Foundation

class TimelineDecoder {
    public func decodeTimeline() -> UserTimeline? {
        do {
            guard let timelineData = getTimelineData() else {
                //            throw NSError(domain: "", code: -1, userInfo: [:])
                print("Cannot get timeline data")
                return nil
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(UserTimeline.self, from: timelineData)
        } catch {
            print(error)
        }

        return nil
    }

    private func getTimelineData() -> Data? {
        guard let path = Bundle.main.path(forResource: "timeline", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            return nil
        }
        return data
    }

}
