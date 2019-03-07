//
//  CloudKitHelper.swift
//  IceAndFire
//
//  Created by Richard Blanchard on 2/21/19.
//  Copyright © 2019 Richard Blanchard. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitHelper {
    static let shared = CloudKitHelper()

    private unowned let publicDatabase = CKContainer.default().publicCloudDatabase

    func saveObject(using ckRecordCreatable: CKRecordCreatable, success: @escaping (CKRecord) -> Void, failure: @escaping (Error?) -> Void) {
        let record = ckRecordCreatable.record

        

        let query = CKQuery(recordType: ckRecordCreatable.record.recordType, predicate: ckRecordCreatable.uniquePredicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 1
        var existingRecord: CKRecord?

        queryOperation.queryCompletionBlock = { _, error in
            // ALSO NEED TO CHECK THAT EVERYTHING IS EXACT SAME
            if let existingRecord = existingRecord {
                success(existingRecord)
            } else {
                self.publicDatabase.save(record) { (record, error) in
                    if let error = error {
                        failure(error)
                    } else if let record = record {
                        success(record)
                    } else {
                        failure(nil)
                    }
                }
            }
        }

        queryOperation.recordFetchedBlock = { record in
            existingRecord = record
        }

        publicDatabase.add(queryOperation)
    }
}
