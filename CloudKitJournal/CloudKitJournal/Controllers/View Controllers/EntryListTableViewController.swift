//
//  EntryListTableViewController.swift
//  CloudKitJournal
//
//  Created by Andrew Saeyang on 8/9/21.
//  Copyright © 2021 Andrew Saeyang. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EntryController.shared.fetchEntryWith { (result) in
            self.updateViews()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.updateViews()
    }
    
    
    // MARK: - HELPER FUNCTIONS
    func updateViews(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.dateAsString()
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        // Identifier
        if segue.identifier == "toDetailVC"{
            // Index Path
            // Destination
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryDetailViewController else { return }
            
            // Object to send
            let entryToSend = EntryController.shared.entries[indexPath.row]
            
            // Object to Recieve
            destination.entry = entryToSend
            
        }
    }
}
