//
//  GetCharacterRequest.swift
//  CloudKit
//
//  Created by Richard Blanchard on 2/21/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import Braavos

struct GetCharacterRequest: APIRequest {

    // MARK: - Types

    struct Payload {
        let number: Int
    }

    // MARK: - APIRequest

    let payload: Payload

    let api: API = APIs.iceAndFire
    private let path = "/api/characters"

    typealias ResponseDataType = Character

    func makeRequest() throws -> URLRequest {
        guard let apiURL = api.baseURL else { fatalError() }

        var urlComponents = URLComponents(url: apiURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = path + "/\(payload.number)"

        if let url = urlComponents?.url {
            return URLRequest(url: url)
        } else {
            fatalError()
        }
    }

    func parseResponse(from data: Data) throws -> Character {
        return try JSONDecoder().decode(Character.self, from: data)
    }
}
