import UIKit
import CoreData

struct CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Individual_Challenge")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()
    
    @discardableResult
    func createName(name: String) -> SearchedUser? {
        let context = persistentContainer.viewContext
        
        let employee = SearchedUser(context: context)

        employee.name = name

        do {
            try context.save()
            return employee
        } catch let error {
            print("Failed to create: \(error)")
        }

        return nil
    }
    
    func createAvatar(avatar_url: String) -> SearchedUser? {
        let context = persistentContainer.viewContext
        
        let avatar = SearchedUser(context: context)

        avatar.avatar_url = avatar_url

        do {
            try context.save()
            return avatar
        } catch let error {
            print("Failed to create: \(error)")
        }

        return nil
    }

    func fetchNames() -> [SearchedUser] {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<SearchedUser>(entityName: "SearchedUser")

        do {
            let employees = try context.fetch(fetchRequest)
            return employees
        } catch let error {
            print("Failed to fetch companies: \(error)")
            return []
        }

    }

    func fetchEmployee(withName name: String) -> SearchedUser? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<SearchedUser>(entityName: "Employee")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let employees = try context.fetch(fetchRequest)
            return employees.first
        } catch let error {
            print("Failed to fetch: \(error)")
        }

        return nil
    }

    func updateNames(employee: SearchedUser) {
        let context = persistentContainer.viewContext

        do {
            try context.save()
        } catch let error {
            print("Failed to update: \(error)")
        }
    }

    func deleteNames(employee: SearchedUser) {
        let context = persistentContainer.viewContext
        context.delete(employee)

        do {
            try context.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }

}
