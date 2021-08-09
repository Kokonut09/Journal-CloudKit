//
//  EntryDetailViewController.swift
//  CloudKitJournal
//
//  Created by Andrew Saeyang on 8/9/21.
//  Copyright © 2021 Andrew Saeyang. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // MARK: - PROPERTIES
    var entry: Entry?{
        didSet{
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
                self.updateViews()
            }
        }
    }

    // MARK: - OUTLETS
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - LIFECYLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    // MARK: - HELPER METHODS
    
    func updateViews(){
        if let entry = entry{
            
            
            titleTextField.text = entry.title
            bodyTextView.text = entry.body
            
            
        }
    }
    
    // MARK: - ACTIONS
    @IBAction func mainViewTapped(_ sender: Any) {
        bodyTextView.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let body = bodyTextView.text, !body.isEmpty,
              let title = titleTextField.text, !title.isEmpty else { return }
        EntryController.shared.createEntryWith(title: title, body: body) { (result) in
            DispatchQueue.main.async {
                
                self.navigationController?.popViewController(animated: true)
                
            }
        }
    }
}

extension EntryDetailViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}
