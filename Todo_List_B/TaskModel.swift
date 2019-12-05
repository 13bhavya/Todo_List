//
//  TaskModel.swift
//  Todo_List_B
//
//  Created by setas on 2019-12-05.
//  Copyright © 2019 student. All rights reserved.
//

class TaskModel{
    
    var id: String!
    var task: String!
    var description: String!
    
    init(id:String!, task:String!, description:String!) {
        self.id = id!
        self.task = task!
        self.description = description!
    }
}
