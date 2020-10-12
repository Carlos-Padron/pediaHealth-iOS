//
//  DoseCollection.swift
//  pediaHealth
//
//  Created by Carlos on 29/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class DoseCollection: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var Button: Button!

    //Variables
    let constants = Constants()
    
    func setButtonConfig(doseType: String, index: Int){
        
        self.Button.titleLabel?.text = doseType
        
        self.Button.backgroundColor = constants.COLOR_ARRAY[index]
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }

    @IBAction func buttonPressed(_ sender: Button) {
        
        print("pressed")
    }
    

}
