//
//  MockAvatarProvider.swift
//  OpenTweetTests
//
//  Created by Chris Gray on 2/2/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import Foundation
import UIKit
@testable import OpenTweet

class MockAvatarProvider: AvatarProvider {
    var error: Bool
    lazy var data = UIImage(systemName: "checkmark")!.pngData()!

    init(error: Bool) {
        self.error = error
    }

    func getUserAvatar(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        return error
            ? completion(.failure(NSError(domain: "", code: -1, userInfo: [:])))
            : completion(.success(data))
    }
}
