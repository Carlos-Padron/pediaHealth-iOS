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
    
    var selectedMainIndex: IndexPath?
    var previousSelectedMainIndex: IndexPath?
    var secondaryCollapsedCellHeight: [Int: CGFloat]  =  [:]
    var secondaryExpandedCellHeight: [Int: CGFloat]   =  [:]
    var isCellActive: [Int: Bool]                     = [:]
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
        
        //Puede funcionar ?
        self.isCellActive[index] = false
        
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
        let expandedHeight: CGFloat       =  cellTextHeight         +  self.textTopAnchor      + self.TextBottomAnchor +                                                                              self.cardBottomAnchor  +  self.cardTopAnchor      + cellUsageTextHeight   +  secondTableHeight   + 45.5
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
                
                cell.setUpCell(enfermedad: self.illness[indexPath.row].nEnfermedad, array: self.illness[indexPath.row].aplicaciones)
                cell.layoutIfNeeded()
                cell.layoutSubviews()
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                
                if  self.isCellActive[indexPath.row] == true {
                    cell.rotateIcon(open: true)
                }else{
                    cell.rotateIcon(open: false)
                }


                
                self.secondaryCollapsedCellHeight[indexPath.row] = cell.collapsedCellHeight()
                self.secondaryExpandedCellHeight[indexPath.row] = cell.expandedCellHeight()
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
                if self.isCellActive[indexPath.row] == true {
                    return self.secondaryExpandedCellHeight[indexPath.row]!
                }
                return self.secondaryCollapsedCellHeight[indexPath.row]!
            }
        }
        return 45

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.previousSelectedMainIndex = self.selectedMainIndex
        self.selectedMainIndex  = indexPath
        
        let cell = tableView.cellForRow(at: self.selectedMainIndex!) as! IllCell
        cell.rotateIcon(open: true)
        self.isCellActive[self.selectedMainIndex!.row] = true
        
        if let indexP = self.previousSelectedMainIndex{
            if indexP.row == self.selectedMainIndex!.row {

                if let cell = tableView.cellForRow(at: indexP) as? MedCellWithTable{
                    cell.rotateIcon(open: false)
                    self.isCellActive[indexP.row] = false
                    self.selectedMainIndex        =  nil
                }else{
                    cell.rotateIcon(open: false)
                    self.isCellActive[indexP.row] = false
                    self.selectedMainIndex        =  nil
                }
                
            }else{
                
                if let cell = tableView.cellForRow(at: indexP) as? MedCellWithTable {
                    cell.rotateIcon(open: false)
                    self.isCellActive[indexP.row] = false
                }
                if let cell = tableView.cellForRow(at: indexP) as? MedCellWithCollection {
                    cell.rotateIcon(open: false)
                    self.isCellActive[indexP.row] = false
                }
                else{
                    self.isCellActive[indexP.row] = false
                }
                
            }
            
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
}
