//
//  HTButton.swift
//  Heady Test
//
//  Created by Malav Soni on 06/03/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class HTButton: UIButton {

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

    init() {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.setTitleColor(UIColor.green, for: UIControl.State.selected)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        
    }
}
