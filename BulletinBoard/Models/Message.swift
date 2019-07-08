//
//  Message.swift
//  BulletinBoard
//
//  Created by Julia Rodriguez on 7/8/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation
import CloudKit

class Message {
    
    // keys for CloudKiy Storage, same value as Class
    // static - accesible everywhere
    static let typeKey = "Message"
    // private doesnt allow to be accessed, cannot acces properties
    private let textKey = "Text"
    private let timestampKey = "Timestamp"
    
    // class properties
    let text: String
    let timestamp: Date
    
    var cloudKitRecord: CKRecord {
        // Defin the record type
        let record = CKRecord(recordType: Message.typeKey)
        // Set your key value pairs
        record.setValue(text, forKey: textKey)
        record.setValue(timestamp, forKey: timestampKey)
        // return the record
        return record
    }
    
    // class initializer
    init(text: String, timestamp: Date = Date()) {
        
        self.text = text
        self.timestamp = timestamp
    }
    
    // failable init to pass in CKRecord
    init?(record: CKRecord) {
        // guard against keys
        guard let text = record[textKey] as? String,
        let timestamp = record[timestampKey] as? Date
            else { return nil }
        // set values for model properties
        self.text = text
        self.timestamp = timestamp
    }
    
}
