//
//  MedCell.swift
//  pediaHealth
//
//  Created by Carlos on 15/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class MedCellWithTable: UITableViewCell {
    
    
    //Outlets
    @IBOutlet weak var medText: UILabel!
    @IBOutlet weak var uso: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    @IBOutlet weak var SecondTable: UITableView!
    
    //Variables
    var illness = [Enfermedad]()
    
    let textTopAnchor: CGFloat                        =  12.0
    let TextBottomAnchor: CGFloat                     =  10.0
    let cardBottomAnchor: CGFloat                     =  9.0
    let cardTopAnchor: CGFloat                        =  2.0

    var mainTableIndex: Int?
    var secondaryCollapsedCellHeight: [Int: CGFloat]  =  [:]
    var secondaryExpandedCellHeight: [Int: CGFloat]   =  [:]
    var cellBool: [Int: Bool]                         =  [:]
     
    

    override func awakeFromNib() {
        super.awakeFromNib()
        secondTableViewSetUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMedName(name: String, uso: String, array: [Enfermedad], index: Int){
        self.medText.text = name
        self.uso.text     = uso
        self.uso.isHidden = true
        
        self.illness = array
        self.mainTableIndex = index

        self.SecondTable.reloadData()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()

    }
    
    func collapsedCellHeight()-> CGFloat{
        let cellTextHeight: CGFloat       =  self.medText.bounds.height
        let collapsedHeight: CGFloat      =  cellTextHeight          +  self.textTopAnchor      +  self.TextBottomAnchor +                                                                            self.cardBottomAnchor   +  self.cardTopAnchor      +  5
        
        return collapsedHeight
    }
    
    func expandedCellHeight()->CGFloat{
        let cellTextHeight: CGFloat       =  self.medText.bounds.height
        let cellUsageTextHeight: CGFloat  =  self.uso.bounds.height
        let secondTableHeight: CGFloat    =  self.SecondTable.bounds.height
        
        //10 es la constante por deault
        let expandedHeight: CGFloat       =  cellTextHeight         +  self.textTopAnchor      + self.TextBottomAnchor +                                                                              self.cardBottomAnchor  +  self.cardTopAnchor      + cellUsageTextHeight   +
                                             50           +      secondTableHeight   // +  secondTableHeight
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

extension MedCellWithTable: UITableViewDelegate, UITableViewDataSource{
    
    
    func updateSecondTableView(){
        self.SecondTable.reloadData()
    }
    
    
    func secondTableViewSetUp(){
        self.SecondTable.delegate = self
        self.SecondTable.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.illness.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === self.SecondTable{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "IllName", for: indexPath) as? IllCell {
                
                cell.setUpCell(enfermedad: self.illness[indexPath.row].nEnfermedad)
                cell.layoutIfNeeded()
                cell.layoutSubviews()
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                
                self.secondaryCollapsedCellHeight[indexPath.row] = cell.getCellHeight()
                self.cellBool[indexPath.row]                     =  true
                return cell
            }
        }
        return  UITableViewCell()
    }
    
    //Sets dynamic height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if self.cellBool[indexPath.row] != nil {
            if self.cellBool[indexPath.row]!{
                
                return self.secondaryCollapsedCellHeight[indexPath.row]!
            }
        }
        return 45

    }
    
}
