//
//  SecondViewController.swift
//  Todo_List_B
//
//  Created by student on 2019-12-04.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import CoreData
import Firebase


class SecondViewController: UIViewController {

    var ref: DatabaseReference!
    //let ref = Database.database().reference()

    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var listInfo: UITextView!
    
    @IBAction func addItem(_ sender: UIButton) {
        if (input.text != "") || (listInfo.text != "")
        {
            saveData()
            //self.ref.child("Task").setValue(["Title" : input])
            //self.ref.child("Task").setValue(["Description" :listInfo])
            //list.append(input.text!)
            //descList.append(listInfo.text!)
            input.text = ""
            listInfo.text = ""
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("Tasks")
        
    }
    
    func saveData() {
        
        let key = ref.childByAutoId().key!
        
        let task = ["task_title": input.text! as String,
                    "task_description": listInfo.text! as String]
        
        ref.child(key).setValue(task)
    }
}

