import Foundation
import CoreData


extension Dish {

    static func createDishesFrom(menuItems:[MenuItem],
                                 _ context:NSManagedObjectContext) {
        
        menuItems.forEach { menuItem in
//            let entity = NSEntityDescription.entity(forEntityName: "Dish", in: context)!
//            let record = NSManagedObject(entity: entity, insertInto: context)
//            
//            record.setValue(menuItem.title, forKey: "title")
//            record.setValue(menuItem.price, forKey: "price")
//            
//            do {
//                try context.save()
//            } catch let error as NSError {
//                print("Could not save. \(error), \(error.userInfo)")
//            }
            if !duplicateCheck(menuItem: menuItem, context: context){
                let dish = Dish(context: context)
                dish.name = menuItem.title
                dish.price = Float(menuItem.price) ?? 0.0
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    static func duplicateCheck(menuItem: MenuItem, context: NSManagedObjectContext) -> Bool {
        do {
            let dishes = try context.fetch(Dish.fetchRequest())
            
            var found =  false
            dishes.forEach { dish in
                if dish.name == menuItem.title && String(dish.price) == menuItem.price {
                    found = true
                }
            }
            return found
        } catch let error as NSError{
            print("Could not fetch data. \(error), \(error.userInfo)")
        }
        return false
    }
    
}
