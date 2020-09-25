//
//  IllCell.swift
//  pediaHealth
//
//  Created by Carlos on 21/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class IllCell: UITableViewCell {
    
    //Varables
    let topBottomAnchor: CGFloat = 16.0
    
    //Outlets
    @IBOutlet weak var enfermedadText: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(enfermedad: String){
        self.enfermedadText.text = enfermedad
    }
    
    func getCellHeight()->CGFloat{
        let cellTextHeight: CGFloat       =  self.enfermedadText.bounds.height
        
        return cellTextHeight + self.topBottomAnchor
    }

}
