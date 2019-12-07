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
    var refresher: UIRefreshControl!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var TaskList = [TaskModel]()
    
    var tasktitle = ""
    var taskdescrip = ""
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let vc = segue.destination as? InfoViewController
            vc?.taskdescrip = taskdescrip
            vc?.tasktitle = tasktitle
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ref.child("Tasks").childByAutoId().removeValue { (error, refer) in
                        if error != nil {
                          print("Failed")
                       } else {
                            self.myTableView.deleteRows(at: [indexPath], with: .fade )
                            print(refer)
                           print("Task removed")
                        }
                    }
        }
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
//   {
////    guard let key = ref.child("Tasks").childByAutoId().key else {
////        return
////    }
//       if editingStyle == .delete {
//        ref.child("Tasks").childByAutoId().removeValue { (error, refer) in
//            if error != nil {
//                print("Failed")
//            } else {
//                self.myTableView.deleteRows(at: [indexPath], with: .fade )
//                print(refer)
//                print("Task removed")
//            }
//        }
//    }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = TaskList[indexPath.row]
        
        tasktitle = index.task!
        taskdescrip = index.description!
        
//        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
     }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    func Fetchdata(){
        ref = Database.database().reference().child("Tasks");
        
        ref.observe(DataEventType.value, with:{(snapshot) in
            
            if snapshot.childrenCount>0{
                //self.TaskList.removeAll()
                
                for tasks in snapshot.children.allObjects as![DataSnapshot]{
                    let taskObject = tasks.value as? [String: AnyObject]
                    
                    
                    let task = TaskModel(id: taskObject?["id"] as? String, task: taskObject?["task_title"] as? String, description: taskObject?["task_description"] as?
                        String )
                    
                    self.TaskList.append(task)
                    //print(tasktitle)
                }
                
            }
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Fetchdata()
    }
}

