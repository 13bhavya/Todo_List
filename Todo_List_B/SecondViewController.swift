//
//  SecondViewController.swift
//  Todo_List_B
//
//  Created by student on 2019-12-04.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import CoreData
class SecondViewController: UIViewController {
    
    

    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var listInfo: UITextView!
    
    @IBAction func addItem(_ sender: UIButton) {
        if (input.text != "") || (listInfo.text != "")
        {
            list.append(input.text!)
            descList.append(listInfo.text!)
            input.text = ""
            listInfo.text = ""
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let newTask = NSManagedObject(entity: entity!, insertInto: context)
        
        newTask.setValue("Morning walking ", forKey: "title")
        newTask.setValue("5 kms ", forKey: "description")
        
        do {
            try context.save()
        } catch{
            print("Failed saving")
        }
    }
}

