//
//  CategoryViewController.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController {
    
    enum CategoryType {
        case mainCategory
        case subCategory
    }

    @IBOutlet weak var tblReference: HTCategoryTableView!
    
    var categoryListType:CategoryType = .mainCategory
    
    var aryCategory:[HTCategory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpTableView()
        if self.categoryListType == .mainCategory{
            self.title = "All Category List"
            if HTServiceManager.isInternetAvailable(){
                HTLoader.shared.showLoader()
                HTServiceManager.shared.getCategoryInfoFromServer {[weak self](isSuccess,aryCategory,error) in
                    guard let controllerRef = self else { return }
                    OperationQueue.main.addOperation {
                        controllerRef.aryCategory = HTCoreDataHelper.shared.getAllCategory()
                        controllerRef.tblReference.aryCategories = controllerRef.aryCategory
                        HTLoader.shared.hideLoader()
                    }
                }
            }else{
                    self.aryCategory = HTCoreDataHelper.shared.getAllCategory()
                    self.tblReference.aryCategories = self.aryCategory
                    HTLoader.shared.hideLoader()
            }
        }else{
            self.tblReference.aryCategories = self.aryCategory
        } 
    }
    
    func setUpTableView() -> Void {
        self.tblReference.didSelectRowNotification = {[weak self](indexPath) in
            guard let controllerRef = self else { return }
            if controllerRef.aryCategory[indexPath.row].childCategory.count > 0{
                if let categoryController = self?.storyboard?.instantiateViewController(withIdentifier: "\(CategoryViewController.self)") as? CategoryViewController{
                    categoryController.categoryListType = .subCategory
                    categoryController.title = controllerRef.aryCategory[indexPath.row].name
                    categoryController.aryCategory = controllerRef.aryCategory[indexPath.row].childCategory
                    controllerRef.navigationController?.pushViewController(categoryController, animated: true)
                }
            }else if controllerRef.aryCategory[indexPath.row].products.count > 0{
                if let productController = self?.storyboard?.instantiateViewController(withIdentifier: "\(ProductListViewController.self)") as? ProductListViewController{
                    productController.title = controllerRef.aryCategory[indexPath.row].name
                    productController.aryProduct = controllerRef.aryCategory[indexPath.row].products
                    controllerRef.navigationController?.pushViewController(productController, animated: true)
                }
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
