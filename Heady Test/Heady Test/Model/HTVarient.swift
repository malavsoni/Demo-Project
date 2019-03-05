//
//  HTVarient.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class HTVarient: NSObject {
    
    private enum APIKeys:String {
        case id = "id"
        case color = "color"
        case price = "price"
        case size = "size"
    }
    
    var id:Int = -1
    var color:String = ""
    var price:Int = 0
    var size:Int = 0
    
    init(WithContent dicContent:[String:Any]) {
        super.init() 
        if let id = dicContent[APIKeys.id.rawValue] as? Int{
            self.id = id
        }
        if let color = dicContent[APIKeys.color.rawValue] as? String{
            self.color = color
        }
        if let price = dicContent[APIKeys.price.rawValue] as? Int{
            self.price = price
        }
        if let size = dicContent[APIKeys.size.rawValue] as? Int{
            self.size = size
        }
    }
    
    init(WithCoreDataObject coreData:Variant) {
        super.init()
        self.id = Int(coreData.id)
        self.color = coreData.color ?? ""
        self.price = Int(coreData.price)
        self.size = Int(coreData.size)
    }
    
    @discardableResult
    func saveToLocalStorage() -> Variant? {
        guard let entity = HTCoreDataHelper.shared.getEntityDescription(ForClassname: "\(Variant.self)") else { return nil }
        let variant = Variant.init(entity: entity, insertInto: HTCoreDataHelper.shared.getCurrentContext())
        variant.id = Int64(self.id)
        variant.color = self.color
        variant.size = Int64(self.size)
        variant.price = Int64(self.price)
        return variant
    }
}
