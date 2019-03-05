//
//  HTTax.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class HTTax: NSObject {
    
    private enum APIKeys:String {
        case name = "name"
        case value = "value" 
    }
    
    var name:String = "N/A"
    var value:Double = 0.0
    
    init(WithContent dicContent:[String:Any]) {
        super.init()
        if let name = dicContent[APIKeys.name.rawValue] as? String{
            self.name = name
        }
        if let value = dicContent[APIKeys.value.rawValue] as? Double{
            self.value = value
        }
    }
    
    @discardableResult
    func saveToLocalStorage() -> Tax? {
        guard let entity = HTCoreDataHelper.shared.getEntityDescription(ForClassname: "\(Tax.self)") else { return nil }
        let tax = Tax.init(entity: entity, insertInto: HTCoreDataHelper.shared.getCurrentContext())
        tax.name = self.name
        tax.value = self.value 
        return tax
    }
}
