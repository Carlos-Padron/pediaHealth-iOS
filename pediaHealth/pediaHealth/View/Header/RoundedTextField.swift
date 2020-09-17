//
//  RoundedTextField.swift
//  pediaHealth
//
//  Created by Carlos on 05/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    @IBInspectable var leftImage: UIImage?{
        didSet{
            setUpImage()
        }
    }
    
    func setUpView(){
        layer.cornerRadius    = frame.height / 2
        clipsToBounds         = true
               
        attributedPlaceholder = NSAttributedString(string: "Buscar", attributes:
            [NSAttributedString.Key.foregroundColor: UIColor(named: "DarkGrey") ?? UIColor(ciColor: .gray)])
    }
    
    func setUpImage(){
        if let image = leftImage {
            let imageView       = UIImageView(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
            imageView.tintColor = UIColor(named: "Grey")
            imageView.image     = image
            
            let view            = UIView(frame: CGRect(x: 0, y: 0, width: 15 + 30, height: 25))
            view.addSubview(imageView)
            
            leftViewMode        = .always
            leftView            = view
            
        }else{
            let view            = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
            leftViewMode        = .always
            leftView            = view
        }

    }
}
