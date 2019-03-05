//
//  HTProduct.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class HTProduct: NSObject {
    private enum APIKeys:String {
        case id = "id"
        case name = "name"
        case dateAdded = "date_added"
        case varients = "variants"
        case tax = "tax"
    }
    var name:String = ""
    var id:Int = -1
    var dateAdded:Date?
    var viewCount:Int = 0
    var shareCount:Int = 0
    var orderCount:Int = 0
    var varients:[HTVarient] = []
    var tax:HTTax!
    
    init(WithContent dicContent:[String:Any]) {
        super.init()
        if let id = dicContent[APIKeys.id.rawValue] as? Int{
            self.id = id
        }
        if let name = dicContent[APIKeys.name.rawValue] as? String{
            self.name = name
        }
        if let aryVarients = dicContent[APIKeys.varients.rawValue] as? [[String:Any]]{
            var aryVarientsObjects:[HTVarient] = []
            for varient in aryVarients{
                aryVarientsObjects.append(HTVarient.init(WithContent: varient))
            }
            self.varients = aryVarientsObjects
        }
        if let dicTax = dicContent[APIKeys.tax.rawValue] as? [String:Any]{
            self.tax = HTTax.init(WithContent: dicTax)
        }
        if let strDateAdded = dicContent[APIKeys.dateAdded.rawValue] as? String{
             let fullFireStoreDateFormate             = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = fullFireStoreDateFormate
            let date = dateFormatter.date(from: strDateAdded)
            self.dateAdded = date
        }
    }
    
    init(WithCoreDataObject coreData:Product) {
        super.init()
        self.id = Int(coreData.id)
        self.name = coreData.name ?? ""
        self.dateAdded = coreData.dateAdded
        
        if let aryVarientsFromCoreData = coreData.varients{
            var aryVarients:[HTVarient] = []
            for varient in aryVarientsFromCoreData{
                if let coreDataObj = varient as? Variant{
                    aryVarients.append(HTVarient.init(WithCoreDataObject: coreDataObj))
                }
            }
            self.varients = aryVarients
        }
        
        if let productTax = coreData.tax{
            self.tax = HTTax.init(WithCoreDataObject: productTax)
        }
    }
    
    @discardableResult
    func saveToLocalStorage() -> Product? {
        guard let entity = HTCoreDataHelper.shared.getEntityDescription(ForClassname: "\(Product.self)") else { return nil }
        let product = Product.init(entity: entity, insertInto: HTCoreDataHelper.shared.getCurrentContext())
        product.id = Int64(self.id)
        product.name = self.name
        product.dateAdded = self.dateAdded
        for varient in self.varients{
            if let coreDataObject = varient.saveToLocalStorage(){
                product.addToVarients(coreDataObject)
            }
        }
        
        if let taxCoreDataObject = tax.saveToLocalStorage(){
            product.tax = taxCoreDataObject
        }
         
        return product
    }
}
