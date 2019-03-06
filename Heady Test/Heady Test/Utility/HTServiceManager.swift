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
    
    class func isInternetAvailable() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func getCategoryInfoFromServer(WithCompletion completion:@escaping ((Bool,[HTCategory],Error?)->())) -> Void {
        if let appURL = URL.init(string: "https://stark-spire-93433.herokuapp.com/json"){
            Alamofire.request(URLRequest.init(url: appURL)).responseJSON { (response) in
                switch response.result{
                case .success(let jsonValue):
                    var aryValueToReturn:[HTCategory] = []
                    if let serverResponse = jsonValue as? [String:Any]{
                        if let aryCategory = serverResponse["categories"] as? [[String:Any]]{
                            
                            // Remove Previous Data from Local Database
                            HTCoreDataHelper.shared.clearDatabase()
                            
                            // Store Category In Local Database
                            for category in aryCategory{
                                let categoryRef = HTCategory.init(WithContent: category)
                                categoryRef.saveToLocalStorage()
                                aryValueToReturn.append(categoryRef)
                            }
                             
                        }
                        if let aryRankings = serverResponse["rankings"] as? [[String:Any]]{
                            // Store Category In Local Database
                            for rankType in aryRankings{
                                if let aryProduct = rankType["products"] as? [[String:Any]]{
                                    for productRank in aryProduct{
                                        if let productViewCount = productRank["view_count"] as? Int, let productId = productRank["id"] as? Int{
                                            if let localDBProductRef = HTCoreDataHelper.shared.getProduct(ById: "\(productId)"){
                                                localDBProductRef.viewCount = productViewCount
                                                localDBProductRef.updateToLocalStorage()
                                            }
                                        }
                                        if let productViewCount = productRank["shares"] as? Int, let productId = productRank["id"] as? Int{
                                            if let localDBProductRef = HTCoreDataHelper.shared.getProduct(ById: "\(productId)"){
                                                localDBProductRef.shareCount = productViewCount
                                                localDBProductRef.updateToLocalStorage()
                                            }
                                        }
                                        if let productViewCount = productRank["order_count"] as? Int, let productId = productRank["id"] as? Int{
                                            if let localDBProductRef = HTCoreDataHelper.shared.getProduct(ById: "\(productId)"){
                                                localDBProductRef.orderCount = productViewCount
                                                localDBProductRef.updateToLocalStorage()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                    completion(true,aryValueToReturn,nil)
                    break
                case .failure(let error):
                    print(error)
                    completion(false,[],error)
                    break
                }
            }
        }
    }
}
