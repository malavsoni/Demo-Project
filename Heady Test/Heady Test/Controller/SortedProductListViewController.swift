//
//  SortedProductListViewController.swift
//  Heady Test
//
//  Created by AgileImac-5 on 06/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class SortedProductListViewController: UIViewController {
    
    @IBOutlet weak var segmentControllRef: UISegmentedControl!
    @IBOutlet weak var tblReference: HTProductListTableView!
    var aryProduct:[HTProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Products"
        self.navigationItem.title = self.title
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
        self.initialContent()
    }
    
    func initialContent() -> Void {
        self.segmentControlValue_Changed(self.segmentControllRef)
    }
    
    @IBAction func segmentControlValue_Changed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.aryProduct = HTCoreDataHelper.shared.getMostViewedProducts()
            self.tblReference.subTitleContentType = .mostViewed
            break
        case 1:
            self.aryProduct = HTCoreDataHelper.shared.getMostOrderedProducts()
            self.tblReference.subTitleContentType = .mostOrdered
            break
        case 2:
            self.aryProduct = HTCoreDataHelper.shared.getMostSharedProducts()
            self.tblReference.subTitleContentType = .mostShared
            break
        default:
            break
        }
        self.tblReference.aryProducts = self.aryProduct
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
