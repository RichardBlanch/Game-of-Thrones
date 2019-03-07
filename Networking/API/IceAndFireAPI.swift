//
//  IceAndFireAPI.swift
//  CloudKit
//
//  Created by Richard Blanchard on 2/21/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import Braavos

struct IceAndFireAPI: API {
    let scheme: String? = "https"
    let host: String? = "anapioficeandfire.com"

    static let shared = IceAndFireAPI()

    private init() {
    }
}
