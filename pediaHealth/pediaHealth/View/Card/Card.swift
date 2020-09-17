//
//  Card.swift
//  pediaHealth
//
//  Created by Carlos on 16/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit
@IBDesignable
class Card: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCardStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCardStyle()
    }
    
    
    func setUpCardStyle(){
       
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 10
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 3
        
        //layer.shadowOffset
        
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
