//
//  ViewController.swift
//  GameOfThrones
//
//  Created by Richard Blanchard on 2/21/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import UIKit
import Braavos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = GetCharacterRequest(payload: GetCharacterRequest.Payload(number: 583))

        APIRequestLoader(apiRequest: request).loadAPIRequest { (result) in
            switch result {
            case .success(let character):
                CloudKitHelper.shared.saveObject(using: character, success: { record in
                    print("Record: \(String(describing: Character.create(from: record)))")
                }, failure: { error in
                    print("Error: \(String(describing: error))")
                })

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                print("")
            }
        }
    }


}

