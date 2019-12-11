//
//  TaskModel.swift
//  Project Name: Todo_List_B
//  Name : Bhavya Shah
//  Student Id: 301076681
//  Developing Todo list

//
//  Created by student on 2019-12-04.
//  Copyright © 2019 student. All rights reserved.
//

class TaskModel{
    
    var id: String?
    var task: String?
    var description: String?
    
    init(id: String?, task:String?, description:String?) {
        self.id = id;
        self.task = task;
        self.description = description;
    }
}
