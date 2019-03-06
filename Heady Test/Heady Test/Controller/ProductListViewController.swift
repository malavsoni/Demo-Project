//
//  ProductListViewController.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class ProductListViewController: BaseViewController {

    @IBOutlet weak var tblReference: HTProductListTableView!
    var aryProduct:[HTProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tblReference.aryProducts = aryProduct
        self.setUpTableView()
    }
    
    func setUpTableView() -> Void {
        self.tblReference.didSelectRowNotification = {[weak self](indexPath) in
            guard let controllerRef = self else { return }
            
            if let vcProductDetails = self?.storyboard?.instantiateViewController(withIdentifier: "\(ProductDetailsViewController.self)") as? ProductDetailsViewController
            {
                vcProductDetails.product = controllerRef.aryProduct[indexPath.row]
                self?.navigationController?.pushViewController(vcProductDetails, animated: true)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
