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
            let currentIndex:String = TaskList[indexPath.row].id ?? ""
            print(currentIndex)
            ref.child(currentIndex).removeValue()
            TaskList.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = TaskList[indexPath.row]
        
        tasktitle = index.task!
        taskdescrip = index.description!
        
        performSegue(withIdentifier: "segue", sender: self)
    }
    
   override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    func Fetchdata(){
        
        //myTableView.reloadData()
        ref = Database.database().reference().child("Tasks");
        
        ref.observeSingleEvent(of: .value) { (snapshots) in
            for case let snapshot as DataSnapshot in snapshots.children{
                let id = snapshot.key
                let value = snapshot.value as? NSDictionary
                let task = value?["task_title"] as? String ?? ""
                let description = value?["task_description"] as? String ?? ""
                let taskObject = TaskModel(id: id, task: task, description: description)
                self.TaskList.append(taskObject)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //myTableView.reloadData()
        Fetchdata()
        
    }
}

