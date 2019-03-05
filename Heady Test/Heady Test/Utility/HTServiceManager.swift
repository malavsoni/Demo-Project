//
//  HTServiceManager.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import Alamofire

class HTServiceManager: NSObject {
    
    static let shared:HTServiceManager = HTServiceManager.init()
    
    override private init() {
        super.init()
    }
    
    func getCategoryInfoFromServer(WithCompletion completion:(()->())) -> Void {
        if let appURL = URL.init(string: "https://stark-spire-93433.herokuapp.com/json"){
            Alamofire.request(URLRequest.init(url: appURL)).responseJSON { (response) in
                switch response.result{
                case .success(let jsonValue):
                    var aryValueToReturn:[HTCategory] = []
                    if let serverResponse = jsonValue as? [String:Any]{
                        if let aryCategory = serverResponse["categories"] as? [[String:Any]]{
                            
                            for category in aryCategory{
                                let categoryRef = HTCategory.init(WithContent: category)
                                categoryRef.saveToLocalStorage()
                                aryValueToReturn.append(categoryRef)
                            }
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
}
