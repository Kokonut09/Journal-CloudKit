//
//  Entry.swift
//  CloudKitJournal
//
//  Created by Andrew Saeyang on 8/9/21.
//  Copyright © 2021 Andrew Saeyang. All rights reserved.
//

import Foundation
import CloudKit

struct EntryConstants{
        static let TitleKey = "title"
        static let BodyKey = "body"
        static let TimestampKey = "timestamp"
    
        static let recordTypeKey = "Entry"
    }//end of struct

class Entry{
    let title: String
    let body: String
    let timestamp: Date
    
    init(title: String, body: String, timestamp: Date = Date()){
        self.title = title
        self.body = body
        self.timestamp = timestamp
        
    }
    

    
}// End of class

//CKRecord -> Entry
extension Entry {
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.TitleKey] as? String,
              let body = ckRecord[EntryConstants.BodyKey] as? String,
              let timestamp = ckRecord[EntryConstants.TimestampKey] as? Date else { return nil }
        
        self.init(title: title, body: body, timestamp: timestamp)
    }
}//end of extension

//Entry -> CKRecord
extension CKRecord {
    convenience init(entry: Entry) {
        self.init (recordType: EntryConstants.recordTypeKey)
        
        self.setValuesForKeys([
            EntryConstants.TitleKey : entry.title,
            EntryConstants.BodyKey : entry.body,
            EntryConstants.TimestampKey : entry.timestamp
        ])
    }
}//end of extension
