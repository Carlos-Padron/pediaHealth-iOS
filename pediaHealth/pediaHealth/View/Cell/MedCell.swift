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
    
    @IBOutlet weak var SecondTable: UITableView!
    
    //Variables
    var illness: [Enfermedad]                =  []
        
    let textTopAnchor: CGFloat               =  12.0
    let TextBottomAnchor: CGFloat            =  10.0
    let cardBottomAnchor: CGFloat            =  9.0
    let cardTopAnchor: CGFloat               =  2.0
    
    var secondaryCollapsedCellHeight: [Int: CGFloat]  =  [:]
    var secondaryExpandedCellHeight: [Int: CGFloat]   =  [:]
    var cellBool: [Int: Bool]                =  [:]
    
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.secondTableViewSetUp()
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
        
        let expandedHeight: CGFloat       =  cellTextHeight         +  self.textTopAnchor      + self.TextBottomAnchor +                                                self.cardBottomAnchor  +  self.cardTopAnchor      + cellUsageTextHeight   + 10 + 80
        return expandedHeight
    }
    
    func rotateIcon(open: Bool){
        let angle: CGFloat = open == true ? CGFloat((Double.pi) / (2)) : CGFloat((Double.pi) * (2))
        
        UIView.animate(withDuration: 0.2, animations: {
            self.uso.isHidden = false
            self.arrowIcon.tintColor = open == true ? UIColor(named: "Text") :  UIColor(named: "DarkGrey")
            self.arrowIcon.transform = CGAffineTransform(rotationAngle: angle)
        }) { (finished: Bool) in
            if !open {
                self.uso.isHidden = true
            }
        }
        
    }

}

//MARK: - Second TableView Config

//extension MedCell: UITableViewDelegate, UITableViewDataSource{
//
//
//    func setEnfmermedadArray(array: [Enfermedad]){
//        self.illness = array
//        if illness.count == 1 {
//            self.SecondTable.isHidden = true
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        self.illness.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "IllCell") as? IllCell {
//
//            cell.setUpCell(enfermedad: self.illness[indexPath.row].nEnfermedad)
//            return cell
//        }
//        return UITableViewCell()
//    }
//
//
//
//    func secondTableViewSetUp(){
//        self.SecondTable.delegate = self
//        self.SecondTable.dataSource = self
//    }
//
//
//}
