//
//  ViewController.swift
//  pediaHealth
//
//  Created by Carlos on 05/09/20.
//  Copyright © 2020 Carlos Padrón. All rights reserved.
//

import UIKit

class MainController: UIViewController{
    
    //Variables
    var selectedMainIndex: IndexPath?
    var previousSelectedMainIndex: IndexPath?
    var collapsedCellHeight: [Int: CGFloat]  = [:]
    var expandedCellHeight: [Int: CGFloat]   = [:]
    var isCellActive: [Int: Bool]            = [:]
    var cellBool: [Int: Bool]                = [:]
    
    var medCatalog = [Medicina](){ didSet{ DispatchQueue.main.async {self.MainTable.reloadData() } } }
    
    //Outlets
    @IBOutlet weak var MainTable: UITableView!

    

    override func viewDidLoad() {
        mainTableViewSetUp()
        getMedCatalog()
    }
     
    //Initial SetUp
    func getMedCatalog(){
        DataService.instance.createMedList { (res) in
            switch res {
            case .success(let medArray):
               
                let sortedArray:[Medicina] = medArray.sorted { (a: Medicina, b: Medicina) -> Bool in
                    return    a.nombre.folding(options: .diacriticInsensitive, locale: .none)
                           <  b.nombre.folding(options: .diacriticInsensitive, locale: .none)
                }
                for (index, _) in medArray.enumerated() {
                    self.isCellActive[index] = false
                }
                self.medCatalog = sortedArray
            case .failure(let error):
                print(error)
            }
        }
    }
    
   
    
    
}

//MARK: - TableView Config 
extension MainController:  UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    func mainTableViewSetUp(){
        self.MainTable.delegate = self
        self.MainTable.dataSource = self
    }
    
    //# Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medCatalog.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Sets Medicine's name
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === MainTable{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MedName") as? MedCell{
                
                let backgroundView              =  UIView()
                backgroundView.backgroundColor  =  UIColor.white.withAlphaComponent(0.0)
                cell.selectedBackgroundView     =  backgroundView
                                
                cell.setMedName(name: self.medCatalog[indexPath.row].nombre, uso: self.medCatalog[indexPath.row].uso , array: self.medCatalog[indexPath.row].enfermedades, index: indexPath.row)
    
                cell.layoutIfNeeded()
                cell.layoutSubviews()
                cell.setNeedsUpdateConstraints()
                cell.updateConstraintsIfNeeded()
                
                if  self.isCellActive[indexPath.row] == true {
                    cell.rotateIcon(open: true)
                }else{
                    cell.rotateIcon(open: false)
                }

                
                self.cellBool[indexPath.row]             =  true
                self.collapsedCellHeight[indexPath.row]  =  cell.collapsedCellHeight()
                self.expandedCellHeight[indexPath.row]  =  cell.expandedCellHeight()
                
                cell.updateSecondTableView()
                return cell
            }
        }
        self.cellBool[indexPath.row]             =   false
        self.collapsedCellHeight[indexPath.row]  =   0.0
        self.expandedCellHeight[indexPath.row]   =   0.0
        return UITableViewCell()
    }
    
    
    //Sets dynamic height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if self.cellBool[indexPath.row] != nil {
            if self.cellBool[indexPath.row]!{
                if self.isCellActive[indexPath.row] == true {
                    return self.expandedCellHeight[indexPath.row]!
                }else{
                    
                    return self.collapsedCellHeight[indexPath.row]!
                }
            }
        }
        return 85
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.previousSelectedMainIndex = self.selectedMainIndex
        self.selectedMainIndex         = indexPath
        
        let cell = tableView.cellForRow(at: self.selectedMainIndex!) as! MedCell
        cell.rotateIcon(open: true)
        self.isCellActive[self.selectedMainIndex!.row] = true
        
        if let indexP = self.previousSelectedMainIndex{
            if indexP.row == self.selectedMainIndex!.row {
                
                let cell = tableView.cellForRow(at: indexP) as! MedCell
                cell.rotateIcon(open: false)
                self.isCellActive[indexP.row] = false
                
                self.selectedMainIndex          =  nil
                self.previousSelectedMainIndex  =  nil
            }else{
                
                if let cell = tableView.cellForRow(at: indexP) as? MedCell {
                    cell.rotateIcon(open: false)
                    self.isCellActive[indexP.row] = false
                }
                
            }
            
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }

}


