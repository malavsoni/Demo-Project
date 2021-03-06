//
//  HTCoreDataHelper.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import CoreData

class HTCoreDataHelper: NSObject {
    
    static let shared:HTCoreDataHelper = HTCoreDataHelper.init()
    
    // MARK: - Core Data stack
    lazy private var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Heady_Test")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func getCurrentContext() -> NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    func getEntityDescription(ForClassname className:String) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: "\(className)", in: self.persistentContainer.viewContext)
    }
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    override private init() {
        super.init()
    }
}

extension HTCoreDataHelper{
    // Helper Methods
    @discardableResult
    /// Get All Category
    ///
    /// - Returns: Array of category
    func getAllCategory() -> [HTCategory] {
        let fetchRequest = NSFetchRequest<Category>(entityName: "\(Category.self)")
        fetchRequest.includesSubentities = true
        fetchRequest.predicate = NSPredicate.init(format: "%K != %@","childCategories","")
        let sort = NSSortDescriptor(key: "childCategories", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        var aryToReturn:[HTCategory] = []
        do {
            let results = try self.getCurrentContext().fetch(fetchRequest)
            for cat in results {
                //print(cat.debugDescription)
                aryToReturn.append(HTCategory.init(WithCoreDataObject: cat))
            }
        } catch  {
            return aryToReturn
        }
        return aryToReturn
    }
    
    /// Get Most Viewed Products
    ///
    /// - Returns: Array of products
    func getMostViewedProducts() -> [HTProduct] {
        let fetchRequest = NSFetchRequest<Product>(entityName: "\(Product.self)")
        fetchRequest.includesSubentities = true
        fetchRequest.predicate = NSPredicate.init(format: "%K > %i","viewCount",0)
        let sort = NSSortDescriptor(key: "viewCount", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        var aryToReturn:[HTProduct] = []
        do {
            let results = try self.getCurrentContext().fetch(fetchRequest)
            for cat in results {
                //print(cat.debugDescription)
                aryToReturn.append(HTProduct.init(WithCoreDataObject: cat))
            }
        } catch  {
            return aryToReturn
        }
        return aryToReturn
    }
    
    /// Get Most Ordered Products
    ///
    /// - Returns: Array of products
    func getMostOrderedProducts() -> [HTProduct] {
        let fetchRequest = NSFetchRequest<Product>(entityName: "\(Product.self)")
        fetchRequest.includesSubentities = true
        fetchRequest.predicate = NSPredicate.init(format: "%K > %i","orderCount",0)
        let sort = NSSortDescriptor(key: "orderCount", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        var aryToReturn:[HTProduct] = []
        do {
            let results = try self.getCurrentContext().fetch(fetchRequest)
            for cat in results {
                //print(cat.debugDescription)
                aryToReturn.append(HTProduct.init(WithCoreDataObject: cat))
            }
        } catch  {
            return aryToReturn
        }
        return aryToReturn
    }
    
    /// Get Most Shared Products
    ///
    /// - Returns: Array of products
    func getMostSharedProducts() -> [HTProduct] {
        let fetchRequest = NSFetchRequest<Product>(entityName: "\(Product.self)")
        fetchRequest.includesSubentities = true
        fetchRequest.predicate = NSPredicate.init(format: "%K > %i","shares",0)
        let sort = NSSortDescriptor(key: "shares", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        var aryToReturn:[HTProduct] = []
        do {
            let results = try self.getCurrentContext().fetch(fetchRequest)
            for cat in results {
                //print(cat.debugDescription)
                aryToReturn.append(HTProduct.init(WithCoreDataObject: cat))
            }
        } catch  {
            return aryToReturn
        }
        return aryToReturn
    }
    
    /// Fetch Category Object By Id
    ///
    /// - Parameter categoryId: Category Id
    /// - Returns: HTCategory object
    func getCategory(ById categoryId:String) -> HTCategory? {
        let fetchRequest = NSFetchRequest<Category>(entityName: "\(Category.self)")
        fetchRequest.includesSubentities = true
        fetchRequest.predicate = NSPredicate.init(format: "%K = %i","id",Int(categoryId)!)
        var valueToReturn:HTCategory?
        do {
            let results = try self.getCurrentContext().fetch(fetchRequest)
            for cat in results {
                valueToReturn = (HTCategory.init(WithCoreDataObject: cat))
            }
        } catch  {
            return valueToReturn
        }
        return valueToReturn
    }
    
    /// Get Product Object By Product ID
    ///
    /// - Parameter productId: product Id
    /// - Returns: HTProduct Object
    func getProduct(ById productId:String) -> HTProduct? {
        let fetchRequest = NSFetchRequest<Product>(entityName: "\(Product.self)")
        fetchRequest.includesSubentities = true
        fetchRequest.predicate = NSPredicate.init(format: "%K = %i","id",Int(productId)!)
        var valueToReturn:HTProduct?
        do {
            let results = try self.getCurrentContext().fetch(fetchRequest)
            for cat in results {
                //print(cat.debugDescription)
                valueToReturn = (HTProduct.init(WithCoreDataObject: cat))
            }
        } catch  {
            return valueToReturn
        }
        return valueToReturn
    }
    
    /// Clear Database
    func clearDatabase() -> Void {
        let categoryFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(Category.self)")
        let categoryDeleteRequest = NSBatchDeleteRequest.init(fetchRequest: categoryFetchRequest)
        
        let productFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(Product.self)")
        let productDeleteRequest = NSBatchDeleteRequest.init(fetchRequest: productFetchRequest)
        
        let varientFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(Variant.self)")
        let varientDeleteRequest = NSBatchDeleteRequest.init(fetchRequest: varientFetchRequest)
        
        let taxFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(Tax.self)")
        let taxDeleteRequest = NSBatchDeleteRequest.init(fetchRequest: taxFetchRequest)
        
        do {
            try self.getCurrentContext().execute(categoryDeleteRequest)
            try self.getCurrentContext().execute(productDeleteRequest)
            try self.getCurrentContext().execute(varientDeleteRequest)
            try self.getCurrentContext().execute(taxDeleteRequest)
            try self.getCurrentContext().save()
        } catch  {
            
        }
    }
}
