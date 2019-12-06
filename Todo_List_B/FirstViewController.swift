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

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    var myIndex = 0
    
    @IBOutlet weak var myTableView: UITableView!
    
    var TaskList = [TaskModel]()
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellController
        
        let task: TaskModel
        
        task = TaskList[indexPath.row]
        cell.showTask.text = task.task
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TaskList.count
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
                
        ref = Database.database().reference().child("Tasks");
        
        ref.observe(DataEventType.value, with:{(snapshot) in
            
            if snapshot.childrenCount>0{
                self.TaskList.removeAll()
                
                for tasks in snapshot.children.allObjects as![DataSnapshot]{
                    let taskObject = tasks.value as? [String: AnyObject]
                    let taskdescription = taskObject?["task_description"]
                    let tasktitle = taskObject?["task_title"]
                    let taskId = taskObject?["id"]
                    
                    let task = TaskModel(id: taskId as! String?, task: tasktitle as! String?, description: taskdescription as! String? )
                    
                    self.TaskList.append(task)
                    //print(tasktitle)
                }
            }
        })
    }
}

