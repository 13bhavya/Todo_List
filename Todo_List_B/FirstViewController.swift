//
//  FirstViewController.swift
//  Todo_List_B
//
//  Created by student on 2019-12-04.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import CoreData
import Firebase

var ref: DatabaseReference!
var myIndex = 0


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var TaskList = [TaskModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TaskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstViewController
        
        let task: TaskModel
        
        task = TaskList[indexPath.row]
        
        //cell.showtask.text = task.task
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
//    {
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            list.remove(at: indexPath.row)
//            myTableView.reloadData()
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
     }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        
        ref.observe(DataEventType.value, with:{(DataSnapshot) in
            
            if DataSnapshot.childrenCount>0{
                self.TaskList.removeAll()
                
                for tasks in DataSnapshot.children.allObjects as![DataSnapshot]{
                    let taskObject = tasks.value as? [String: AnyObject]
                    let tasktitle = taskObject?["tasktitle"]
                    let taskdescription = taskObject?["taskdescription"]
                    let taskId = taskObject?["id"]
                    
                    let task = TaskModel(id: taskId as! String?, task: tasktitle as! String?, description: taskdescription as! String? )
                }
            }
        })
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as!
            [NSManagedObject] {
            print(data.value(forKey: "title") as! String)
            }
        } catch {
            print("Failed")
        }
    }
}

