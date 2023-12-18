//
//  HomeViewModel.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI
import CoreData

final class HomeViewModel: ObservableObject {
    
    @Published var staffs: [StaffModel] = []
    
    @AppStorage("reminders") var reminders: [String] = []
    
    @Published var reminder_field: String = ""
    @Published var isReminderAdd: Bool = false
    
    func addReminder() {
        
        if !reminders.contains(reminder_field) {
            
            reminders.append(reminder_field)
            
        }
        
        withAnimation(.spring()) {
            
            isReminderAdd = false
        }
        
        reminder_field = ""
        
        UIApplication.shared.endEditing()
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
