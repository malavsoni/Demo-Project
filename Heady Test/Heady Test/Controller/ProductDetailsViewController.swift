//
//  ProductDetailsViewController.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class ProductDetailsViewController: BaseViewController {

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductAddedOn: UILabel!
    @IBOutlet weak var stackAvailableVarients: UIStackView!
    @IBOutlet weak var lblTaxType: UILabel!
    @IBOutlet weak var lblTaxValue: UILabel!
    
    @IBOutlet weak var lblTotalOrderPlaced: UILabel!
    @IBOutlet weak var lblTotalShares: UILabel!
    @IBOutlet weak var lblTotalViews: UILabel!
    
    
    var product:HTProduct!
    
    var selectedVarient:HTVarient?
    
    var selectedSize:Int = -1
    var selectedColor:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpUI()
    }
    
    func setUpUI() -> Void {
        
        self.title = "Product Details"
        
        self.lblProductName.text = self.product.name
        
        if let dateAddedOn = self.product.dateAdded{
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateStyle = .medium
            self.lblProductAddedOn.text = dateFormatter.string(from: dateAddedOn)
        }
        
        self.lblTotalViews.text = "\(self.product.viewCount)"
        self.lblTotalShares.text = "\(self.product.shareCount)"
        self.lblTotalOrderPlaced.text = "\(self.product.orderCount)"
        
        self.lblTaxType.text = "Tax( \(self.product.tax.name) ):"
        self.lblTaxValue.text = "\(self.product.tax.value)"
        
        for varient in self.product.varients {
            let viewVarient = HTProductVarientView.loadFromXib()
            viewVarient.updateInfo(varient: varient)
            self.stackAvailableVarients.addArrangedSubview(viewVarient)
        }
        self.stackAvailableVarients.layoutIfNeeded()
        
        //self.findVarientBasedOnSelection()
        
        self.view.layoutIfNeeded()
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
