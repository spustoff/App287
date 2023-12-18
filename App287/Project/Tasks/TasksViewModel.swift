//
//  TasksViewModel.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI
import CoreData

final class TasksViewModel: ObservableObject {
    
    @Published var tasks: [TaskModel] = []
    @Published var staffs: [StaffModel] = []
    
    @Published var name: String = ""
    @Published var executor: String = ""
    @Published var text: String = ""
    @Published var status: String = ""
    @Published var statuses: [String] = ["Open", "Closed"]
    
    @Published var comment: String = ""
    
    @Published var isAddTask: Bool = false
    
    func addTask() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "TaskModel", into: context) as! TaskModel
        
        loan.name = name
        loan.executor = executor
        loan.text = text
        loan.status = status
        loan.comment = comment
        loan.date = Date()
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchTasks() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TaskModel>(entityName: "TaskModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.tasks = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.tasks = []
        }
    }
    
    func fetchStaff() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<StaffModel>(entityName: "StaffModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.staffs = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.staffs = []
        }
    }
}
