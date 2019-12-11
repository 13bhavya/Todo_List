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
    
    var ref: DatabaseReference!
    //var Title = [String]()
    //var descrip = [String]()
    //var ref: DatabaseReference!
    //var databaseHandle:DatabaseHandle!
    var taskId = ""
    var tasktitle = ""
    var taskdescrip = ""
    public var firstViewController:FirstViewController!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var descField: UITextView!
    
    @IBAction func backBtn(_ sender: UIButton) {
        func prepare(for segue: UIStoryboardSegue,
                     sender: AnyObject?) {
           
        }
    }
    
    @IBAction func updateBtn(_ sender: UIButton) {
        guard let key = ref.child("Tasks").child(taskId).key else {
            return
        }
        let task = ["task_description" : descField.text,
                    "task_title" : titleLabel.text ]
        ref.child(key).updateChildValues(task)
        firstViewController.viewData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("Tasks")
                
        titleLabel.text = tasktitle
        descField.text = taskdescrip
        
    }
}
