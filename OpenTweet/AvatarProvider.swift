//
//  AvatarProvider.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/30/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class AvatarProvider {
    func getUserAvatar(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return completion(.failure(error!))
            }

            guard let data = data else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [:])))
            }

            return completion(.success(data))
        }.resume()
    }
}
