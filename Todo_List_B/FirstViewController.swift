//
//  FirstViewController.swift
//  Todo_List_B
//
//  Created by student on 2019-12-04.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import CoreData

var list = ["Buy Milk", "Run 5 miles", "Study templates"]

var descList = ["Need to buy milk as only 1 is left", "Eun 10 miles everyday, morning n Night", "Study Assign 4 Notes"]

var myIndex = 0

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (list.count)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            list.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }
    
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

