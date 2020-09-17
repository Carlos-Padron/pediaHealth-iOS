//
//  BotomRoundedRectangle.swift
//  pediaHealth
//
//  Created by Carlos on 05/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class BotomRoundedRectangle: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpVIew()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpVIew()
    }
    
    func setUpVIew(){
        layer.cornerRadius = 39
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    
}
