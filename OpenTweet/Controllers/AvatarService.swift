//
//  AvatarService.swift
//  OpenTweet
//
//  Created by Chris Gray on 1/30/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

protocol AvatarProvider {
    func getUserAvatar(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class AvatarService: AvatarProvider {
    /// URL Session for getting avatar images.
    /// - Parameters:
    ///   - url: The URL for the image.
    ///   - completion: Returns a result type with data/error when the task completes.
    func getUserAvatar(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                return completion(.failure(error!))
            }

            guard let data = data else {
                return completion(
                    .failure(
                        NSError(
                            domain: "",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Data is not valid"]
                        )
                    )
                )
            }

            return completion(.success(data))
        }.resume()
    }
}
