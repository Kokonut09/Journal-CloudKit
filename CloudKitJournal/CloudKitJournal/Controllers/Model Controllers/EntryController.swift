//
//  EntryController.swift
//  CloudKitJournal
//
//  Created by Andrew Saeyang on 8/9/21.
//  Copyright © 2021 Andrew Saeyang. All rights reserved.
//

import Foundation
import CloudKit

class EntryController{
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    // MARK: - PROPERTIES
    
    var entries: [Entry] = []
    
    static let shared = EntryController()
    
    // MARK: - CRUD FUNCTIONS
    
    func createEntryWith(title: String, body: String, completion: @escaping (Result<Entry?, EntryError>) -> Void){
        let newEntry = Entry(title: title, body: body)
        
        saveEntry(entry: newEntry, completion: completion)
        
    }
    
    func saveEntry(entry: Entry, completion: @escaping (Result<Entry?, EntryError>) -> Void){
        
        let entryRecord = CKRecord(entry: entry)
        
        publicDB.save(entryRecord) { record, error in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                  let savedEntry = Entry(ckRecord: record) else { return completion(.failure(.couldNotUnwrap))}
            
            print("Saved Entry successfully")
            
            self.entries.insert(savedEntry, at: 0)
            
            completion(.success(savedEntry))
            
        }
    }
    
    func fetchEntryWith(completion: @escaping (Result<[Entry], EntryError>) -> Void){
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryConstants.recordTypeKey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let recordsUnwrapped = records else { return completion(.failure(.couldNotUnwrap))}
            
            print("Records have been fetched uccessfully")
            
            let entries = recordsUnwrapped.compactMap({ Entry(ckRecord: $0) })
            
            self.entries = entries
            
            completion(.success(entries))
            
        }
        
    }
}// End of class



