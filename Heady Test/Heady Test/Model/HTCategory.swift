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
        case childCategory = "child_categories"
    }
    
    var id:Int = -1
    var name:String = ""
    var products:[HTProduct] = []
    var childCategory:[HTCategory] = []
    var aryChildCategoryId:[String] = []
    
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
        if let aryCategory = dicContent[APIKeys.childCategory.rawValue] as? [Int]{
            for intValue in aryCategory{
                self.aryChildCategoryId.append("\(intValue)")
            }
        }
    }
    
    init(WithCoreDataObject coreData:Category) {
        super.init()
        self.id = Int(coreData.id)
        self.name = coreData.name ?? ""
        
        if let strCategory = coreData.childCategories{
            let aryCategory = strCategory.split(separator: ",") 
            for categoryId in aryCategory{
                if let category = HTCoreDataHelper.shared.getCategory(ById: String(categoryId)){
                    self.childCategory.append(category)
                }
            }
        }
        
//        if let aryCategoryFromCoreData = coreData.childCategories{
//            var aryCategory:[HTCategory] = []
//            for objCategory in aryCategoryFromCoreData{
//                if let coreDataObj = objCategory as? Category{
//                    aryCategory.append(HTCategory.init(WithCoreDataObject: coreDataObj))
//                }
//            }
//            self.childCategory = aryCategory
//        }
        
        if let aryCategoryFromCoreData = coreData.products{
            var aryCategory:[HTProduct] = []
            for objCategory in aryCategoryFromCoreData{
                if let coreDataObj = objCategory as? Product{
                    aryCategory.append(HTProduct.init(WithCoreDataObject: coreDataObj))
                }
            }
            self.products = aryCategory
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
        
        category.childCategories = aryChildCategoryId.joined(separator: ",")
        
//        category.childCategories = aryChildCategoryId.
        
//        for childCategory in self.childCategory{
//            if let coreDataObject = childCategory.saveToLocalStorage(){
//                category.addToChildCategories(coreDataObject)
//            }
//        }
        
        HTCoreDataHelper.shared.saveContext()
        return category
    }
}
