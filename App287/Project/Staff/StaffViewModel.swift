//
//  StaffViewModel.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI
import CoreData

final class StaffViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var post: String = ""
    @Published var work_schedule: Date = Date()
    
    @Published var staffs: [StaffModel] = []
    
    @Published var isAddStuff: Bool = false
    
    func addStaff() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "StaffModel", into: context) as! StaffModel
        
        loan.name = name
        loan.post = post
        loan.working_from = work_schedule
        
        CoreDataStack.shared.saveContext()
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
