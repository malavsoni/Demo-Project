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
    @IBOutlet weak var stackAvailableColors: UIStackView!
    @IBOutlet weak var stackAvailableSizes: UIStackView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblTaxType: UILabel!
    @IBOutlet weak var lblTaxValue: UILabel!
    
    var product:HTProduct!
    
    var selectedVarient:HTVarient?{
        didSet{
            if let value = selectedVarient{
                self.lblTotalAmount.text = "$\(value.price)"
            }
        }
    }
    
    var selectedSize:Int = -1
    var selectedColor:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpUI()
    }
    
    func setUpUI() -> Void {
        self.lblProductName.text = self.product.name
        
        if let dateAddedOn = self.product.dateAdded{
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateStyle = .medium
            self.lblProductAddedOn.text = dateFormatter.string(from: dateAddedOn)
        }
        
        self.lblTaxType.text = "Tax( \(self.product.tax.name) ):"
        self.lblTaxValue.text = "\(self.product.tax.value)"
        
        
        var aryColorsButton:[HTButton] = []
        var arySizesButton:[HTButton] = []
        for varient in self.product.varients {
            let indexOfColorButton = aryColorsButton.firstIndex(where: { (btn) -> Bool in
                if let titleOfButton = btn.title(for: UIControl.State.normal){
                    return titleOfButton.lowercased() == varient.color.lowercased()
                }
                return false
            })
            if indexOfColorButton == nil{
                let btnColor = HTButton.init()
                btnColor.setTitle(varient.color, for: UIControl.State.normal)
                btnColor.tag = 1
                btnColor.addTarget(self, action: #selector(self.didSelectButton(button:)), for: UIControl.Event.touchUpInside)
                if aryColorsButton.count == 0{
                    self.selectedColor = varient.color
                }
                aryColorsButton.append(btnColor)
                self.stackAvailableColors.addArrangedSubview(btnColor)
                self.stackAvailableColors.layoutIfNeeded()
            }
            
            // Size
            let indexOfSizeButton = arySizesButton.firstIndex(where: { (btn) -> Bool in
                if let titleOfButton = btn.title(for: UIControl.State.normal){
                    return titleOfButton.lowercased() == "\(varient.size)".lowercased()
                }
                return false
            })
            if indexOfSizeButton == nil{
                let btnSize = HTButton.init()
                btnSize.setTitle("\(varient.size)", for: UIControl.State.normal)
                btnSize.tag = 2
                if arySizesButton.count == 0{
                    selectedSize = varient.size
                }
                btnSize.addTarget(self, action: #selector(self.didSelectButton(button:)), for: UIControl.Event.touchUpInside)
                arySizesButton.append(btnSize)
                self.stackAvailableSizes.addArrangedSubview(btnSize)
                self.stackAvailableSizes.layoutIfNeeded()
            }
        }
        
        self.findVarientBasedOnSelection()
        
        
        self.view.layoutIfNeeded()
    }
    
    func findVarientBasedOnSelection() -> Void {
        if let searchedVarient = self.product.varients.first(where: { (varient) -> Bool in
            return (varient.color.lowercased() == self.selectedColor) && (varient.size == self.selectedSize)
        }){
            self.selectedVarient = searchedVarient
        }
    }
    
   @objc func didSelectButton(button:HTButton) -> Void {
        if button.tag == 1{
            // Color Changed
        }else if button.tag == 2{
            // Size Changed
        }
    self.findVarientBasedOnSelection()
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
