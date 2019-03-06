//
//  HTProductVarient.swift
//  Heady Test
//
//  Created by AgileImac-5 on 06/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class HTProductVarientView: UIView,XibLoadable {

    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func updateInfo(varient:HTVarient) -> Void {
        self.lblColor.text = "Color : \(varient.color)"
        self.lblSize.text = "Size : \(varient.size)"
        self.lblAmount.text = "Amount : $\(varient.price)"
    }
    
    
    
}

protocol XibLoadable {
    associatedtype CustomViewType
    static func loadFromXib() -> CustomViewType
}

extension XibLoadable where Self: UIView {
    static func loadFromXib() -> Self {
        let nib = UINib(nibName: "\(self)", bundle: Bundle(for: self))
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            // your app should crash if the xib doesn't exist
            preconditionFailure("Couldn't load xib for view: \(self)")
        }
        return customView
    }
}
