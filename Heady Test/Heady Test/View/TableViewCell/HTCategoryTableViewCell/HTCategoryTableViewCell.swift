//
//  HTCategoryTableViewCell.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class HTCategoryTableViewCell: HTTableViewCell {

    @IBOutlet weak private var lblCategoryName: UILabel!
    @IBOutlet weak private var lblSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(WithContent content:HTCategory) -> Void {
        self.lblCategoryName.text = " \(content.name)"
        if content.childCategory.count > 0{
            self.lblSubTitle.text = "\(content.childCategory.count) Category"
        }else if content.products.count > 0{
            self.lblSubTitle.text = "\(content.products.count) Products"
        }else{
            self.lblSubTitle.text = "N/A"
        }
    }
    
    func updateCell(WithContent content:HTProduct, WithContentType rightContentType:HTProductListTableView.SubTitleContentType) -> Void {
        self.lblCategoryName.text = "\(content.name)"
        switch rightContentType {
        case .varient:
            self.lblSubTitle.text = "\(content.varients.count) Variants"
            break
        case .mostOrdered:
            self.lblSubTitle.text = "\(content.orderCount) Ordered"
            break
        case .mostShared:
            self.lblSubTitle.text = "\(content.shareCount) Shared"
            break
        case .mostViewed:
            self.lblSubTitle.text = "\(content.viewCount) Viewed"
            break
        }
        
    }
}
