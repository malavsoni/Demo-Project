//
//  HTProductListTableView.swift
//  Heady Test
//
//  Created by Malav Soni on 04/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class HTProductListTableView: HTTableView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var aryProducts:[HTProduct] = []{
        didSet{
            self.reloadData()
        }
    }
    
    override func commonInit() {
        self.rowHeight = UITableView.automaticDimension
        self.register(UINib.init(nibName: "\(HTCategoryTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(HTCategoryTableViewCell.self)")
        super.commonInit()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellRef = tableView.dequeueReusableCell(withIdentifier: "\(HTCategoryTableViewCell.self)") as! HTCategoryTableViewCell
        cellRef.updateCell(WithContent: self.aryProducts[indexPath.row])
        return cellRef
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
