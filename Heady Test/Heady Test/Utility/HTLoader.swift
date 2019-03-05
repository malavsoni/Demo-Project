//
//  HTLoader.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import SVProgressHUD
class HTLoader: NSObject {
   static  let shared:HTLoader = HTLoader.init()
    
    override private init() {
        super.init()
    }
    
    func showLoader() -> Void {
        SVProgressHUD.show(withStatus: "Loading...")
    }
    func hideLoader() -> Void {
        SVProgressHUD.dismiss()
    }
}
