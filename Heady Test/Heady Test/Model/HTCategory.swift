//
//  HTCategory.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class HTCategory: NSObject {
    
    private enum APIKeys:String {
        case id = "id"
        case name = "name"
        case products = "products"
        case childCategory = "child_category"
    }
    
    var id:Int = -1
    var name:String = ""
    var products:[HTProduct] = []
    var childCategory:[HTCategory] = []
    
    init(WithContent dicContent:[String:Any]) {
        super.init()
        if let id = dicContent[APIKeys.id.rawValue] as? Int{
            self.id = id
        }
        if let name = dicContent[APIKeys.name.rawValue] as? String{
            self.name = name
        }
        if let aryProducts = dicContent[APIKeys.products.rawValue] as? [[String:Any]]{
            var aryProductObjects:[HTProduct] = []
            for product in aryProducts{
                aryProductObjects.append(HTProduct.init(WithContent: product))
            }
            self.products = aryProductObjects
        }
        if let aryCategory = dicContent[APIKeys.childCategory.rawValue] as? [[String:Any]]{
            var aryCategoryObjects:[HTCategory] = []
            for category in aryCategory{
                aryCategoryObjects.append(HTCategory.init(WithContent: category))
            }
            self.childCategory = aryCategoryObjects
        }
    }
    
    @discardableResult
    func saveToLocalStorage() -> Category? {
        guard let entity = HTCoreDataHelper.shared.getEntityDescription(ForClassname: "\(Category.self)") else { return nil }
        let category = Category.init(entity: entity, insertInto: HTCoreDataHelper.shared.getCurrentContext())
        category.id = Int64(self.id)
        category.name = self.name
        
        //HTCoreDataHelper.shared.saveContext()
        
        for product in self.products{
            if let coreDataObject = product.saveToLocalStorage(){
                category.addToProducts(coreDataObject)
            }
        }
        
        for childCategory in self.childCategory{
            if let coreDataObject = childCategory.saveToLocalStorage(){
                category.addToChildCategories(coreDataObject)
            }
        }
        
        HTCoreDataHelper.shared.saveContext()
        return category
    }
}
