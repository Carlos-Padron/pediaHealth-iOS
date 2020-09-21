//
//  MedCell.swift
//  pediaHealth
//
//  Created by Carlos on 15/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class MedCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var medText: UILabel!
    @IBOutlet weak var uso: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    //Variables
    let textTopAnchor: CGFloat        =  12.0
    let TextBottomAnchor: CGFloat     =  10.0
    let cardBottomAnchor: CGFloat     =  9.0
    let cardTopAnchor: CGFloat        =  2.0

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMedName(name: String, uso: String){
        self.medText.text = name
        self.uso.text     = uso
        self.uso.isHidden = true
    }
    
    func collapsedCellHeight()-> CGFloat{
        
        let cellTextHeight: CGFloat       =  self.medText.bounds.size.height
        let collapsedHeight: CGFloat      =  cellTextHeight          +  self.textTopAnchor      +  self.TextBottomAnchor +                                              self.cardBottomAnchor   +  self.cardTopAnchor      +  5

        return collapsedHeight
        
    }
    
    func expandedCellHeight()->CGFloat{
        let cellTextHeight: CGFloat       =  self.medText.bounds.height
        let cellUsageTextHeight: CGFloat  =  self.uso.bounds.height
        
        let expandedHeight: CGFloat       =  cellTextHeight         +  self.textTopAnchor      + self.TextBottomAnchor +                                                self.cardBottomAnchor  +  self.cardTopAnchor      + cellUsageTextHeight   + 10
        return expandedHeight
        
    }
    
    func rotateIcon(open: Bool){
        let angle: CGFloat = open == true ? CGFloat((Double.pi) / (2)) : CGFloat((Double.pi) * (2))
        UIView.animate(withDuration: 0.2) {
            self.arrowIcon.tintColor = open == true ? UIColor(named: "Text") :  UIColor(named: "DarkGrey")
            self.arrowIcon.transform = CGAffineTransform(rotationAngle: angle)
        }
        
    }
     

    
}
