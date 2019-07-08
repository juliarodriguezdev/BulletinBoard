//
//  MessageController.swift
//  BulletinBoard
//
//  Created by Julia Rodriguez on 7/8/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation

class MessageController {
    
    // shared instance: singleton
    static let sharedInstance = MessageController()
    
    let messagesWereUpdatedNotification = Notification.Name("messagesWereUpdated")
    
    // source of truth
    var messages: [Message] = [] {
        didSet {
            // Post a notification
            NotificationCenter.default.post(name: messagesWereUpdatedNotification, object: nil)
        }
    }
    
    // MARK: - CRUD
    // Create
    func saveMessageRecord(_ text: String) {
        
        //init a message
        let messageToSave = Message(text: text)
        let database = CloudKitController.sharedInstance.publicDatabase
        
        CloudKitController.sharedInstance.saveRecordToCloudKit(record:
        // call bool 'success' - auto defaults to true
        messageToSave.cloudKitRecord, database: database) { (success) in
            if success {
                print("Sucessfully saved Message to CloudKit")
               self.messages.append(messageToSave)
            }
        }
    }
    
    // Read
    func fetchMessageRecords() {
        let database = CloudKitController.sharedInstance.publicDatabase
        CloudKitController.sharedInstance.fetchRecordsOf(type: MessageConstants.typeKey, database: database) { (records, error) in
            
            // handle error
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) /n ---/n \(error)")
            }
            
            // verify records exist
            guard let foundRecords = records else { return }
            
            // iterates through foundRecords, initializes Messages from the values that can init a message, creating a new array from successes
            let messages = foundRecords.compactMap( {Message(record: $0)} )
            
            // set source of truth
            self.messages = messages
        }
    }
    
    // Delete
  /*  func deleteMessageRecords(_ text: String) {
        let messageToDelete = Message(text: text)
        let database = CloudKitController.sharedInstance.publicDatabase
        
        CloudKitController.sharedInstance.recordToDelete(record: messageToDelete.cloudKitRecord, database: database) { (success) in
            if success {
                print("Successfully deleted message from CloudKit")
                self.messages.remove(at: messageToDelete.cloudKitRecord.)
            }
            
        }
        
    } */
}
