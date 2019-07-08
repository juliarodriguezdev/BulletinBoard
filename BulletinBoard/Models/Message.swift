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
    
    // class properties
    let text: String
    let timestamp: Date
    
    var cloudKitRecord: CKRecord {
        // Defin the record type
        let record = CKRecord(recordType: MessageConstants.typeKey)
        // Set your key value pairs
        record.setValue(text, forKey: MessageConstants.textKey)
        record.setValue(timestamp, forKey: MessageConstants.timestampKey)
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
        guard let text = record[MessageConstants.textKey] as? String,
        let timestamp = record[MessageConstants.timestampKey] as? Date
            else { return nil }
        // set values for model properties
        self.text = text
        self.timestamp = timestamp
    }
    
}

// step 1 - to delete messages
extension Message: Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.text == rhs.text && lhs.timestamp == rhs.timestamp
    }
}

struct MessageConstants {
    
    // keys for CloudKiy Storage, same value as Class
    // static - accesible everywhere
    static let typeKey = "Message"
    // private doesnt allow to be accessed, cannot acces properties
    // fileprivate: only use in this file
    fileprivate static let textKey = "Text"
    fileprivate static let timestampKey = "Timestamp"
}
