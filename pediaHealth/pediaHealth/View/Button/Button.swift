//
//  Button.swift
//  pediaHealth
//
//  Created by Carlos on 28/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit


class Button: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpView()
    }
    
    func setUpView(){
        layer.cornerRadius = 22.0
        //clipsToBounds = true
        
    }
    
    
}
