//
//  InfoViewController.swift
//  Todo_List_B
//
//  Created by Student on 2019-12-04.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase

class InfoViewController: UIViewController {
    
    var Title = [String]()
    var descrip = [String]()
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var descField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("Tasks")
                
//        databaseHandle =  ref?.child("Tasks").observe(.childAdded, with: { (snapshot) in
//
//
//            let post = snapshot.value as? String
//            if let actualPost = post {
//                self.Title.append(actualPost)
//
//
//            }
//        })
    }
}
