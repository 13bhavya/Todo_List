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

    var ref = DatabaseReference.init()
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
        ref = Database.database().reference()
        
    }
    
    func saveData() {
        self.ref.child("Task").child("title").setValue(input)
        self.ref.child("Task").child("description").setValue(listInfo)
    }
}

